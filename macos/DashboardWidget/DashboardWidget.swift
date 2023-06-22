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
        
        SimpleEntry(date: Date(),
                    configuration: ConfigurationIntent(),
                    widgetData: WidgetData(url: "url", companyId: "", companies: [:]),
                    field: "Active Invoices",
                    value: "$100.00")
    }
    
    func getSnapshot(for configuration: ConfigurationIntent,
                     in context: Context,
                     completion: @escaping (SimpleEntry) -> ()) {
        
        let entry = SimpleEntry(date: Date(),
                                configuration: configuration,
                                widgetData: WidgetData(url: "url", companyId: "", companies: [:]),
                                field: "Active Invoices",
                                value: "$100.00")
        
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent,
                     in context: Context,
                     completion: @escaping (Timeline<Entry>) -> ()) {
        
        print("## getTimeline")
        
        Task {
            
            let sharedDefaults = UserDefaults.init(suiteName: "group.com.invoiceninja.app")
            var widgetData: WidgetData? = nil
            
            if sharedDefaults == nil {
                return
            }
            
            do {
                let shared = sharedDefaults!.string(forKey: "widget_data")
                if shared == nil {
                    return
                }
                
                //print("## Shared: \(shared!)")
                
                let decoder = JSONDecoder()
                widgetData = try decoder.decode(WidgetData.self, from: shared!.data(using: .utf8)!)
                
                if (widgetData?.url == nil) {
                    return
                }
                
                let url = (widgetData?.url ?? "") + "/charts/totals_v2";
                let companyId = configuration.company?.identifier ?? ""
                let company = widgetData?.companies[companyId]
                var token = company?.token
                
                if (token == "" && !(widgetData?.companies.isEmpty)!) {
                    print("## WARNING: using first token")
                    let company = widgetData?.companies.values.first;
                    token = company?.token ?? ""
                }
                
                print("## company.name: \(configuration.company?.displayString ?? "")")
                print("## company.id: \(configuration.company?.identifier ?? "")")
                //print("## URL: \(url)")
                
                if (token == "") {
                    return
                }
                
                guard let result = try? await ApiService.post(urlString: url, apiToken: token!) else {
                    return
                }
                
                let currencyId = configuration.currency?.identifier ?? company?.currencyId
                let currency = company?.currencies[currencyId!]
                
                var value = 0.0
                var label = ""
                let data = result[currencyId ?? "1"]
                
                if (data != nil) {
                    if (configuration.field == Field.active_invoices) {
                        if (data?.invoices?.invoicedAmount != nil) {
                            value = Double(data?.invoices?.invoicedAmount ?? "")!
                        }
                        label = "Active Invoices"
                    } else if (configuration.field == Field.outstanding_invoices) {
                        if (data?.outstanding?.amount != nil) {
                            value = Double(data?.outstanding?.amount ?? "")!
                        }
                        label = "Outstanding Invoices"
                    } else if (configuration.field == Field.completed_payments) {
                        if (data?.revenue?.paidToDate != nil) {
                            value = Double(data?.revenue?.paidToDate ?? "")!
                        }
                        label = "Completed Payments"
                    }
                }
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                formatter.currencyCode = currency?.code ?? "USD"
                
                let entry = SimpleEntry(date: Date(),
                                        configuration: configuration,
                                        widgetData: widgetData,
                                        field: label,
                                        value: formatter.string(from: NSNumber(value: value))!)
                
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
                
            } catch {
                print(error)
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
    let code: String
    let exchangeRate: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case exchangeRate = "exchange_rate"
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let widgetData: WidgetData?
    let field: String
    let value: String
}

struct DashboardWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            //Rectangle().fill(BackgroundStyle())
            Rectangle().fill(Color.blue)
            VStack(alignment: .leading) {
                
                HStack {
                    VStack {
                        Text(entry.field)
                            .font(.body)
                            .bold()
                            .foregroundColor(Color.blue)
                        Text(entry.value)
                            .font(.title)
                            .privacySensitive()
                            .foregroundColor(Color.gray)
                            .minimumScaleFactor(0.8)
                    }
                    .padding(.all)
                    
                }
                .padding(.top, 8)
                .background(ContainerRelativeShape().fill(Color(.white)))
                //.shadow(color: .gray, radius: 4, x: 4, y: 4)
                
                Spacer()
                
                Text(entry.configuration.company?.displayString ?? "")
                    .font(.body)
                    .bold()
                    .foregroundColor(Color.white)
                
                Text("Last 30 days")
                    .font(.caption)
                    .foregroundColor(Color.white)
                
            }
            .padding(.all)
        }
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
        let entry = SimpleEntry(date: Date(),
                                configuration: ConfigurationIntent(),
                                widgetData: WidgetData(url: "url", companyId: "", companies: [:]),
                                field: "Active Invoices",
                                value: "$100.00")
        
        DashboardWidgetEntryView(entry: entry)
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
    let currencyId: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case invoicedAmount = "invoiced_amount"
        case currencyId = "currency_id"
        case code
    }
}

struct Revenue: Codable {
    let paidToDate: String?
    let currencyId: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case paidToDate = "paid_to_date"
        case currencyId = "currency_id"
        case code
    }
}

struct Outstanding: Codable {
    let amount: String?
    let outstandingCount: Int?
    let currencyId: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case amount
        case outstandingCount = "outstanding_count"
        case currencyId = "currency_id"
        case code
    }
}

struct Expenses: Codable {
    let amount: String?
    let currencyId: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case amount
        case currencyId = "currency_id"
        case code
    }
}


struct ApiService {
    
    static func post(urlString: String, apiToken: String) async throws -> [String: ApiResult]? {
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiToken, forHTTPHeaderField: "X-API-Token")
        request.addValue("macOS Widget", forHTTPHeaderField: "X-CLIENT")
        
        let dataDict: [String: String] = [
            "start_date": "2020-12-30",
            "end_date": "2023-12-31",
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dataDict, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error: Failed to serialize data - \(error)")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            // process data
            
            //print("## Details: \(String(describing: String(data: data, encoding: .utf8)))")
            let result = try JSONDecoder().decode([String: ApiResult].self, from: data)
            
            return result
            
        } catch {
            print("Error: \(error)")
        }
        
        return nil
    }
}


