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
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), widgetData: WidgetData(url: "url", tokens: ["plk": "ply"]))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, widgetData: WidgetData(url: "url", tokens: ["sk": "sy"]))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("## getTimeline")
        

        Task {
                
            let sharedDefaults = UserDefaults.init(suiteName: "group.com.invoiceninja.app")
            var exampleData: WidgetData? = nil

            if sharedDefaults != nil {
              do {
                let shared = sharedDefaults!.string(forKey: "widgetData")
                if shared != nil {
                  let decoder = JSONDecoder()
                  exampleData = try decoder.decode(WidgetData.self, from: shared!.data(using: .utf8)!)
                    
                    if (exampleData?.url != nil) {
                        
                        let url = (exampleData?.url ?? "") + "/charts/totals_v2";
                        let token = configuration.company?.token ?? "";
                        guard let result = try? await ApiService.post(urlString: url, apiToken: token) else {
                            return
                        }
                        
                        let entry = SimpleEntry(date: Date(), configuration: configuration, widgetData: exampleData)
                        
                        // Next fetch happens 15 minutes later
                        let nextUpdate = Calendar.current.date(
                            byAdding: DateComponents(minute: 15),
                            to: Date()
                        )!
                        
                        let timeline = Timeline(
                            entries: [entry],
                            policy: .after(nextUpdate)
                        )
                        
                        completion(timeline)
                    }
                }
              } catch {
                print(error)
              }
            }

        }
    }
}

struct WidgetData: Decodable, Hashable {
    let url: String
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
        //Text("TEST \(entry.configuration.field.rawValue)")
        VStack {
            //Text(entry.configuration.company?.identifier ?? "")
            Text(entry.configuration.company?.displayString ?? "")
            Text(entry.widgetData?.url ?? "")
        }
        
        /*
        ZStack {
            Rectangle().fill(BackgroundStyle())
            VStack(alignment: .leading) {
                Text("Balance")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                Text("$123.00")
                    .privacySensitive()
                    .font(.title2)
                    .foregroundColor(Color.gray)
            }
        }
        */
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
        DashboardWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), widgetData: WidgetData(url: "url", tokens: ["pk": "py"])))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            //.environment(\.sizeCategory, .extraLarge)
            //.environment(\.colorScheme, .dark)
    }
}


struct ApiResult: Decodable {
    let message: URL
    let status: String
}

struct ApiService {

    static func post(urlString: String, apiToken: String) async throws -> ApiResult {

        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiToken, forHTTPHeaderField: "api-token")

        let (data, _) = try await URLSession.shared.data(for: request)

        let result = try JSONDecoder().decode(ApiResult.self, from: data)

        return result
    }

}

