//
//  DashboardWidget.swift
//  DashboardWidget
//
//  Created by hillel on 12/06/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), widgetData: WidgetData(tokens: ["plk": "ply"]))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, widgetData: WidgetData(tokens: ["sk": "sy"]))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("## getTimeline")
        var entries: [SimpleEntry] = []

        let sharedDefaults = UserDefaults.init(suiteName: "group.com.invoiceninja.app")
        var exampleData: WidgetData? = nil

        if sharedDefaults != nil {
          do {
            let shared = sharedDefaults!.string(forKey: "widgetData")
            if shared != nil {
              let decoder = JSONDecoder()
              exampleData = try decoder.decode(WidgetData.self, from: shared!.data(using: .utf8)!)
            }
          } catch {
            print(error)
          }
        }

        print("## DATA IS: \(exampleData)")
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, configuration: configuration, widgetData: exampleData)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetData: Decodable, Hashable {
    let tokens: [String: String]
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let widgetData: WidgetData?
}

struct DashboardWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        //Text(entry.widgetData?.tokens.keys.joined() ?? "BLANK")
        Text("TEST \(entry.configuration.field.rawValue)")
    }
}

@main
struct DashboardWidget: Widget {
    let kind: String = "DashboardWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DashboardWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Dashboard")
        .description("View total from dashboard.")
        .supportedFamilies([.systemSmall,])
    }
}

struct DashboardWidget_Previews: PreviewProvider {
    static var previews: some View {
        DashboardWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), widgetData: WidgetData(tokens: ["pk": "py"])))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
