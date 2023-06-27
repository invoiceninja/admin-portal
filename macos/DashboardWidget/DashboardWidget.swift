//
//  DashboardWidget.swift
//  DashboardWidget
//
//  Created by hillel on 12/06/2023.
//

import WidgetKit
import SwiftUI
import Intents

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        
        SimpleEntry(date: Date(),
                    configuration: ConfigurationIntent(),
                    widgetData: WidgetData(url: "url", companyId: "", companies: [:], dateRanges: [:]),
                    field: "Active Invoices",
                    value: "$100.00")
    }
    
    func getSnapshot(for configuration: ConfigurationIntent,
                     in context: Context,
                     completion: @escaping (SimpleEntry) -> ()) {
        
        let entry = SimpleEntry(date: Date(),
                                configuration: configuration,
                                widgetData: WidgetData(url: "url", companyId: "", companies: [:], dateRanges: [:]),
                                field: "Active Invoices",
                                value: "$100.00")
        
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent,
                     in context: Context,
                     completion: @escaping (Timeline<Entry>) -> ()) {
        
        print("## getTimeline")
        
        Task {
            
            var rawValue = 0.0
            var value = "Error"
            var label = ""
            
            let sharedDefaults = UserDefaults.init(suiteName: "group.com.invoiceninja.app")
            var widgetData: WidgetData? = nil
            
            if sharedDefaults != nil {
                do {
                    let shared = sharedDefaults!.string(forKey: "widget_data")
                    if shared != nil {
                        
                        //print("## Shared: \(shared!)")
                        
                        let decoder = JSONDecoder()
                        widgetData = try decoder.decode(WidgetData.self, from: shared!.data(using: .utf8)!)
                        
                        let companyId = configuration.company?.identifier ?? ""
                        let company = widgetData?.companies[companyId]
                        let currencyId = configuration.currency?.identifier ?? company?.currencyId
                        let currency = company?.currencies[currencyId!]
                        
                        
                        if (widgetData?.url == nil) {
                            return
                        }
                        
                        let url = (widgetData?.url ?? "") + "/charts/totals_v2";
                        var token = company?.token
                        let (startDate, endDate) = getDateRange(dateRange: (configuration.dateRange?.identifier)!,
                                                                firstMonthOfYear: company!.firstMonthOfYear)
                        
                        if (token == "" && !(widgetData?.companies.isEmpty)!) {
                            print("## WARNING: using first token")
                            let company = widgetData?.companies.values.first;
                            token = company?.token ?? ""
                        }
                        
                        print("## company.name: \(configuration.company?.displayString ?? "")")
                        print("## company.id: \(configuration.company?.identifier ?? "")")
                        print("## Date Range: \(String(describing: configuration.dateRange?.identifier)) => \(startDate) - \(endDate)")
                        //print("## URL: \(url)")
                        
                        if (token == "") {
                            return
                        }
                        
                        
                        let result = try await ApiService.post(urlString: url,
                                                               apiToken: token!,
                                                               startDate: startDate,
                                                               endDate: endDate)!
                        
                        let data = result[currencyId ?? "1"]
                        
                        if (data != nil) {
                            if (configuration.field == Field.active_invoices) {
                                if (data?.invoices?.invoicedAmount != nil) {
                                    rawValue = Double(data?.invoices?.invoicedAmount ?? "")!
                                }
                                label = "Active Invoices"
                            } else if (configuration.field == Field.outstanding_invoices) {
                                if (data?.outstanding?.amount != nil) {
                                    rawValue = Double(data?.outstanding?.amount ?? "")!
                                }
                                label = "Outstanding Invoices"
                            } else if (configuration.field == Field.completed_payments) {
                                if (data?.revenue?.paidToDate != nil) {
                                    rawValue = Double(data?.revenue?.paidToDate ?? "")!
                                }
                                label = "Completed Payments"
                            }
                        }
                        
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .currency
                        formatter.currencyCode = currency?.code ?? "USD"
                        value = formatter.string(from: NSNumber(value: rawValue))!
                        
                    }
                } catch {
                    print("## ERROR: \(error)")
                    //value = "\(error)"
                }
            }
            
            print("## VALUE: \(value)")
            
            let entry = SimpleEntry(date: Date(),
                                    configuration: configuration,
                                    widgetData: widgetData,
                                    field: label,
                                    value: value)
            
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

    
    func getDateRange(dateRange: String, firstMonthOfYear: Int = 1) -> (start: String, end: String) {
        
        let today = Date()
        let calendar = Calendar.current
        
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today))!
        
        let year = calendar.component(.year, from: today) - (firstMonthOfYear > calendar.component(.month, from: today) ? 1 : 0)
        let firstDayOfYear = calendar.date(from: DateComponents(year: year, month: firstMonthOfYear, day: 1))!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var start: Date = Date()
        var end: Date = Date()
        
        if (dateRange == "all_time") {
            start = calendar.date(byAdding: .year, value: -100, to: Date())!
        } else if (dateRange == "today") {
            start = calendar.startOfDay(for: Date())
        } else if (dateRange == "yesterday") {
            start = calendar.date(byAdding: .day, value: -1, to: Date())!
            end = start
        } else if (dateRange == "last7_days" ){
            start = calendar.date(byAdding: .day, value: -7, to: Date())!
        } else if (dateRange == "last30_days") {
            start = calendar.date(byAdding: .day, value: -30, to: Date())!
        } else if (dateRange == "last365_days") {
            start = calendar.date(byAdding: .day, value: -365, to: Date())!
        } else if (dateRange == "this_month") {
            start = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        } else if (dateRange == "last_month") {
            let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: Date())!
            start = calendar.date(from: calendar.dateComponents([.year, .month], from: previousMonthDate))!
            end = calendar.date(byAdding: .month, value: 1, to: start)!.addingTimeInterval(-1)
        } else if (dateRange == "this_quarter") {
            let monthOffset = (calendar.component(.month, from: today) - 1) % 3 * -1
            start = calendar.date(byAdding: .month, value: monthOffset, to: firstDayOfMonth)!
            end = calendar.date(byAdding: .month, value: 3, to: start)!.addingTimeInterval(-1)
        } else if (dateRange == "last_quarter") {
            let monthOffset = (calendar.component(.month, from: today) - 1) % 3 * -1
            start = calendar.date(byAdding: .month, value: monthOffset - 3, to: firstDayOfMonth)!
            end = calendar.date(byAdding: .month, value: 3, to: start)!.addingTimeInterval(-1)
        } else if (dateRange == "this_year") {
            start = firstDayOfYear
            end = calendar.date(byAdding: .year, value: 1, to: start)!.addingTimeInterval(-1)
        } else if (dateRange == "last_year") {
            start = calendar.date(byAdding: .year, value: -1, to: firstDayOfYear)!
            end = calendar.date(byAdding: .year, value: 1, to: start)!.addingTimeInterval(-1)
        }
        
        return (dateFormatter.string(from: start), dateFormatter.string(from: end))
    }
}

struct WidgetData: Decodable, Hashable {
    let url: String
    let companyId: String
    let companies: [String: WidgetCompany]
    let dateRanges: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case url
        case companyId = "company_id"
        case companies
        case dateRanges = "date_ranges"
    }
}

struct WidgetCompany: Decodable, Hashable {
    let id: String
    let name: String
    let token: String
    let firstMonthOfYear: Int
    let accentColor: String
    let currencyId: String
    let currencies: [String: WidgetCurrency]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case token
        case firstMonthOfYear = "first_month_of_year"
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
    @Environment(\.colorScheme) var colorScheme
    var entry: Provider.Entry
    
    var accentColor: Color {
        let companyId = entry.configuration.company?.identifier ?? ""
        return Color(hex: (entry.widgetData?.companies[companyId]?.accentColor ?? "#0000ff")!)
    }
    
    var body: some View {
        ZStack {
            Rectangle().fill(accentColor)
            VStack(alignment: .leading) {
                
                HStack {
                    VStack {
                        Text(entry.field)
                            .font(.body)
                            .bold()
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(accentColor)
                        Text(entry.value)
                            .font(.title)
                            .privacySensitive()
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                    }
                    .padding(.all)
                }
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 8)
                .background(ContainerRelativeShape().fill(Color(colorScheme == .dark ? .black : .white)))
                
                Spacer()
                
                Text(entry.configuration.company?.displayString ?? "")
                    .font(.body)
                    .bold()
                    .foregroundColor(Color.white)
                
                Text(entry.configuration.dateRange?.displayString ?? "")
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
                                widgetData: WidgetData(url: "url", companyId: "", companies: [:], dateRanges: [:]),
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

struct ApiResultError: Codable {
    let message: String
    let errors: [String: String]
}

enum ApiError: Error {
    case message(String)
}

struct ApiService {
    
    static func post(urlString: String, apiToken: String, startDate: String, endDate: String) async throws -> [String: ApiResult]? {
        
        let url = URL(string: "\(urlString)?start_date=\(startDate)&end_date=\(endDate)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiToken, forHTTPHeaderField: "X-API-Token")
        request.addValue("macOS Widget", forHTTPHeaderField: "X-CLIENT")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode >= 200 && statusCode < 300 {
                    //print("## Details WAS: \(String(describing: String(data: data, encoding: .utf8)))")
                    //print("## Details IS: \(String(describing: String(data: try! ApiService.fixData(data: data), encoding: .utf8)))")
                    
                    //let result = try JSONDecoder().decode([String: ApiResult].self, from: data)
                    let result = try JSONDecoder().decode([String: ApiResult].self, from: ApiService.fixData(data: data))
                    
                    return result
                } else {
                    let result = try JSONDecoder().decode(ApiResultError.self, from: data)
                    
                    throw ApiError.message("\(statusCode): \(result.message)")
                }
            }
        } catch {
            throw ApiError.message("\(error)")
        }
        
        return nil
    }
    
    static func fixData(data: Data) throws -> Data {
        var dataString = String(data: data, encoding: .utf8)!
        
        if let range = dataString.range(of: "\"currencies\":\\{[^\\}]*?\\},", options: .regularExpression) {
            dataString.removeSubrange(range)
        }
        
        if let range = dataString.range(of: "\"start_date\":[^\\}]*?,", options: .regularExpression) {
            dataString.removeSubrange(range)
        }
        
        if let range = dataString.range(of: "\"end_date\":[^\\}]*?,", options: .regularExpression) {
            dataString.removeSubrange(range)
        }
        
        return dataString.data(using: .utf8)!
        
    }
}
