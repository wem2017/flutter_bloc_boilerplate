//
//  MediumWidget.swift
//  SaleBoltExtension
//
//  Created by Hanbiro on 29/03/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct MediumProvider: IntentTimelineProvider {
    
    // MARK: placeholder
    func placeholder(in context: Context) -> MediumWidgetEntry {
        MediumWidgetEntry(
            date: Date(),
            configuration: ConfigurationIntent(),
            data: MediumProvider.getData()
        )
    }
    
    // MARK: getSnapshot
    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (MediumWidgetEntry) -> ()
    ) {
        let entry = MediumWidgetEntry(date: Date(), configuration: configuration, data: MediumProvider.getData())
        completion(entry)
    }
    
    // MARK: getTimeline
    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        var entries: [MediumWidgetEntry] = []
        let entry = MediumWidgetEntry(date: Date(), configuration: configuration, data: MediumProvider.getData())
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    // MARK: getData
    static func getData() -> (authenticated: Bool, item: MediumWidgetModel?)  {
        let sharedDefaults = UserDefaults.init(suiteName: "group.com.envato")
        var item: MediumWidgetModel?
        var authenticated = false
        if(sharedDefaults != nil) {
            do {
                authenticated = sharedDefaults?.bool(forKey: "authenticated") ?? false
                let medium = sharedDefaults?.string(forKey: "medium")
                if(medium != nil){
                    let decoder = JSONDecoder()
                    item = try decoder.decode(MediumWidgetModel.self, from: medium!.data(using: .utf8)!)
                }
            } catch {
                print(error)
            }
        }
        return (authenticated, item)
    }
}

// MARK: MediumWidgetEntry
struct MediumWidgetEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let data: (authenticated: Bool, item: MediumWidgetModel?)
}

// MARK: MediumWidgetEntryView
struct MediumWidgetEntryView : View {
    var entry: MediumProvider.Entry
    
    var body: some View {
        if(entry.data.authenticated){
            if(entry.data.item == nil){
                Text("Loading...").font(.caption)
            }else{
                VStack(alignment: .center) {
                    Text(entry.data.item!.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Spacer()
                    VStack(alignment: .center, spacing: 4){
                        HStack(alignment: .center){
                            Text("Earning").font(.caption2)
                            Spacer()
                            Text("$\(String(format:"%.1f", entry.data.item!.earning ))")
                                .foregroundColor(Color(red: 0.51, green: 0.71, blue: 0.25))
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        Divider()
                        HStack(alignment: .center){
                            Text("Sale").font(.caption2)
                            Spacer()
                            Text("\(entry.data.item!.sale)")
                                .foregroundColor(Color(red: 0.51, green: 0.71, blue: 0.25))
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        Divider()
                        HStack(alignment: .center){
                            Text("Refund").font(.caption2)
                            Spacer()
                            Text("\(entry.data.item!.refund)")
                                .foregroundColor(.red)
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        Divider()
                        HStack(alignment: .center){
                            Text("Reversal").font(.caption2)
                            Spacer()
                            Text("\(entry.data.item!.reversal)")
                                .foregroundColor(.red)
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        
                        
                    }.frame(maxHeight: .infinity)
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }else{
            Text("The feature need require sign in.").font(.caption).frame(alignment: .center)
        }
        
    }
    
}

// MARK: MediumWidget
struct MediumWidget: Widget {
    let kind: String = "MediumWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: MediumProvider()) { entry in
            MediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Report")
        .description("Preview report your sale by poriod.").supportedFamilies([.systemMedium])
    }
}

// MARK: MediumWidget_Previews
struct MediumWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        MediumWidgetEntryView(
            entry: MediumWidgetEntry(
                date: Date(),
                configuration: ConfigurationIntent(),
                data: MediumProvider.getData()
            )
        ).previewContext(WidgetPreviewContext(family:.systemMedium))
    }
}
