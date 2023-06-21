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
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), widgetData: WidgetData(url: "url", companyId: "", companies: [:]), field: "Invoices", value: 0)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, widgetData: WidgetData(url: "url", companyId: "", companies: [:]), field: "Invoices", value: 0)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("## getTimeline")
        
        /*
        if (configuration.company == nil) {
            return
        }
        */
        
        Task {
                
            let sharedDefaults = UserDefaults.init(suiteName: "group.com.invoiceninja.app")
            var exampleData: WidgetData? = nil

            if sharedDefaults != nil {
              do {
                let shared = sharedDefaults!.string(forKey: "widget_data")
                if shared != nil {
                    
                    print("## Shared: \(shared!)")
                    
                  let decoder = JSONDecoder()
                  exampleData = try decoder.decode(WidgetData.self, from: shared!.data(using: .utf8)!)
                    
                    if (exampleData?.url != nil) {
                        
                        let url = (exampleData?.url ?? "") + "/charts/totals_v2";
                        var token = configuration.company?.identifier ?? ""
                        
                        if (token == "" && !(exampleData?.companies.isEmpty)!) {
                            let company = exampleData?.companies.values.first;
                            token = company?.token ?? ""
                        }

                        print("## company.name: \(configuration.company?.displayString ?? "")")
                        print("## company.id: \(configuration.company?.identifier ?? "")")
                        //print("## URL: \(url)")
                        
                        if (token == "") {
                            return
                        }
                            
                        guard let result = try? await ApiService.post(urlString: url, apiToken: token) else {
                            return
                        }
                        
                        
                        let currencyId = result.keys.first;
                        let value = Double((result[currencyId!]?.invoices?.invoicedAmount ?? ""))
                        
                        let entry = SimpleEntry(date: Date(), configuration: configuration, widgetData: exampleData, field: "Invoices", value: value ?? 0)
                        
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
    let companyId: String
    let companies: [String: WidgetCompany]
    
    enum CodingKeys: String, CodingKey {
        case url
        case companyId = "company_id"
        case companies
    }
}

struct WidgetCompany: Decodable, Hashable {
    let id: String
    let name: String
    let token: String
    let accentColor: String
    let currencyId: String
    let currencies: [String: WidgetCurrency]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case token
        case accentColor = "accent_color"
        case currencyId = "currency_id"
        case currencies
    }
}

struct WidgetCurrency: Decodable, Hashable {
    let id: String
    let name: String
    let exchangeRate: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case exchangeRate = "exchange_rate"
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let widgetData: WidgetData?
    let field: String
    let value: Double
}

struct DashboardWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        //Text(entry.widgetData?.tokens.keys.joined() ?? "BLANK")
        //Text("TEST \(entry.configuration.field.rawValue)")
        VStack {
            //Text(entry.configuration.company?.identifier ?? "")
            Text(entry.field)
            Text("Value: \(entry.value)")
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
        DashboardWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), widgetData: WidgetData(url: "url", companyId: "", companies: [:]), field: "Invoices", value: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            //.environment(\.sizeCategory, .extraLarge)
            //.environment(\.colorScheme, .dark)
    }
}


struct ApiResult: Codable {
    let invoices: Invoices?
    let revenue: Revenue?
    let outstanding: Outstanding?
    let expenses: Expenses?
}

struct Invoices: Codable {
    let invoicedAmount: String?
    let currencyID: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case invoicedAmount = "invoiced_amount"
        case currencyID = "currency_id"
        case code
    }
}

struct Revenue: Codable {
    let paidToDate: String?
    let currencyID: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case paidToDate = "paid_to_date"
        case currencyID = "currency_id"
        case code
    }
}

struct Outstanding: Codable {
    let amount: String?
    let outstandingCount: Int?
    let currencyID: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case amount
        case outstandingCount = "outstanding_count"
        case currencyID = "currency_id"
        case code
    }
}

struct Expenses: Codable {
    let amount: String?
    let currencyID: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case amount
        case currencyID = "currency_id"
        case code
    }
}


struct ApiService {

    static func post(urlString: String, apiToken: String) async throws -> [String: ApiResult] {

        let url = URL(string: urlString)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiToken, forHTTPHeaderField: "X-Api-Token")
        
        let dataDict: [String: Any] = [
            "start_date": "2022-12-30",
            "end_date": "2023-12-31",
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dataDict, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error: Failed to serialize data - \(error)")
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        //print("## Details: \(details)")
      
        let result = try JSONDecoder().decode([String: ApiResult].self, from: ApiService.fixData(data: data))

        print("## Result: \(result)")
        
        
        return result
    }
    
    static func fixData(data: Data) throws -> Data {
        var dataString = String(data: data, encoding: .utf8)!
        
        if let range = dataString.range(of: "\"currencies\":\\{[^\\}]*\\},", options: .regularExpression) {
            dataString.removeSubrange(range)
        }
        
        return dataString.data(using: .utf8)!

    }
}

