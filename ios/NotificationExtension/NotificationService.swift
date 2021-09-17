//
//  NotificationService.swift
//  NotificationExtension
//
//  Created by HUYNH on 8/5/20.
//

import UserNotifications
import UIKit

@available(iOS 10.0, *)
class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {

            guard let imageURL = bestAttemptContent.userInfo["image"] as? String else {
              contentHandler(bestAttemptContent)
              return
            }

            getMediaAttachment(for: imageURL) { [weak self] image in

              guard
                let self = self,
                let image = image,
                let fileURL = self.saveImageAttachment(
                  image: image,
                  forIdentifier: "attachment.png")
                else {
                  contentHandler(bestAttemptContent)
                  return
              }

              let imageAttachment = try? UNNotificationAttachment(
                identifier: "image",
                url: fileURL,
                options: nil)

              if let imageAttachment = imageAttachment {
                bestAttemptContent.attachments = [imageAttachment]
              }

              contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    private func saveImageAttachment(
      image: UIImage,
      forIdentifier identifier: String
    ) -> URL? {

      let tempDirectory = URL(fileURLWithPath: NSTemporaryDirectory())

      let directoryPath = tempDirectory.appendingPathComponent(
        ProcessInfo.processInfo.globallyUniqueString,
        isDirectory: true)

      do {

        try FileManager.default.createDirectory(
          at: directoryPath,
          withIntermediateDirectories: true,
          attributes: nil)

        let fileURL = directoryPath.appendingPathComponent(identifier)

        guard let imageData = image.pngData() else {
          return nil
        }

        try imageData.write(to: fileURL)
          return fileURL
        } catch {
          return nil
      }
    }
    
    private func getMediaAttachment(
      for urlString: String,
      completion: @escaping (UIImage?) -> Void
    ) {

      guard let url = URL(string: urlString) else {
        completion(nil)
        return
      }

      ImageDownloader.shared.downloadImage(forURL: url) { result in

        guard let image = try? result.get() else {
          completion(nil)
          return
        }

        completion(image)
      }
    }
}
