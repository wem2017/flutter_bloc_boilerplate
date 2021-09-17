//
//  SmallWidget.swift
//  SaleBoltExtension
//
//  Created by Hanbiro on 29/03/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct SmallProvider: IntentTimelineProvider {
    
    // MARK: placeholder
    func placeholder(in context: Context) -> SmallWidgetEntry {
        SmallWidgetEntry(
            date: Date(),
            configuration: ConfigurationIntent(),
            data: SmallProvider.getData()
        )
    }
    
    // MARK: getSnapshot
    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (SmallWidgetEntry) -> ()
    ) {
        let entry = SmallWidgetEntry(date: Date(), configuration: configuration, data: SmallProvider.getData())
        completion(entry)
    }
    
    // MARK: getTimeline
    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        var entries: [SmallWidgetEntry] = []
        let entry = SmallWidgetEntry(date: Date(), configuration: configuration, data: SmallProvider.getData())
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    // MARK: getData
    static func getData() -> (authenticated: Bool, item: SmallWidgetModel?)  {
        let sharedDefaults = UserDefaults.init(suiteName: "group.com.envato")
        var item: SmallWidgetModel?
        var authenticated = false
        if(sharedDefaults != nil) {
            do {
                authenticated = sharedDefaults?.bool(forKey: "authenticated") ?? false
                let small = sharedDefaults?.string(forKey: "small")
                if(small != nil){
                    let decoder = JSONDecoder()
                    item = try decoder.decode(SmallWidgetModel.self, from: small!.data(using: .utf8)!)
                }
            } catch {
                print(error)
            }
        }
        return (authenticated, item)
    }
}

// MARK: SmallWidgetEntry
struct SmallWidgetEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let data: (authenticated: Bool, item: SmallWidgetModel?)
}

// MARK: SmallWidgetEntryView
struct SmallWidgetEntryView : View {
    var entry: SmallProvider.Entry
    
    func countTax(item: SmallWidgetModel) -> String {
        let tax:Float = item.auGTS + item.euVAT + item.usRWT + item.usBWT
        if(tax > 0){
            return "\(String(format:"%.1f", tax)) Tax"
        }
        return ""
    }
    
    var body: some View {
        if(entry.data.authenticated){
            if(entry.data.item == nil){
                Text("Loading...").font(.caption)
            }else{
                VStack(alignment: .leading) {
                    NetworkImage(url:entry.data.item!.image).frame(minWidth: 56, minHeight: 56)
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.data.item!.detail ).font(.caption).fontWeight(.medium).lineLimit(1)
                        HStack(alignment: .center){
                            Text("$\(String(format:"%.1f", entry.data.item!.amount ))")
                                .foregroundColor(Color(red: 0.51, green: 0.71, blue: 0.25))
                                .font(.body)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Spacer()
                            Text(countTax(item: entry.data.item!)).foregroundColor(.red).font(.caption2).lineLimit(1)
                        }
                        Text(entry.data.item!.date ).font(.system(size: 12)).lineLimit(1)
                    }.padding(.top, 4)
                    
                }
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }else{
            Text("The feature need require sign in.").font(.caption).frame(alignment: .center)
        }
        
    }
    
}

// MARK: SmallWidget
struct SmallWidget: Widget {
    let kind: String = "SmallWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: SmallProvider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Latest Sale")
        .description("Preview your latest your item sale.").supportedFamilies([.systemSmall])
    }
}

// MARK: SmallWidget_Previews
struct SmallWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        SmallWidgetEntryView(
            entry: SmallWidgetEntry(
                date: Date(),
                configuration: ConfigurationIntent(),
                data: SmallProvider.getData()
            )
        ).previewContext(WidgetPreviewContext(family:.systemSmall))
    }
}
