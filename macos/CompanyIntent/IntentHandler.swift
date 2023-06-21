import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    private func loadWidgetData() -> WidgetData {
        let sharedDefaults = UserDefaults(suiteName: "group.com.invoiceninja.app")
        var widgetData: WidgetData = WidgetData(url: "", companyId: "", companies: [:])

        if let sharedDefaults = sharedDefaults {
            do {
                if let shared = sharedDefaults.string(forKey: "widget_data") {
                    let decoder = JSONDecoder()
                    widgetData = try decoder.decode(WidgetData.self, from: shared.data(using: .utf8)!)
                }
            } catch {
                print(error)
            }
        }
        
        return widgetData
    }
    
    func provideCompanyOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<Company> {
        let widgetData = loadWidgetData()
        
        let companies = widgetData.companies.values.map { company in
            Company(identifier: company.id, display: company.name)
        }
        
        return INObjectCollection(items: companies)
    }
    
    func defaultCompany(for intent: ConfigurationIntent) -> Company? {
        let widgetData = loadWidgetData()
        let company = widgetData.companies[widgetData.companyId];
        return Company(identifier: company!.id, display: company!.name)
    }
    
    func provideCurrencyOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<Currency> {
        let widgetData = loadWidgetData()
        
        let company = widgetData.companies[(intent.company?.identifier!)!]
        let currencies = company!.currencies.values.map { currency in
            Currency(identifier: currency.id, display: currency.name)
        }
        
        return INObjectCollection(items: currencies)
    }
    
    func defaultCurrency(for intent: ConfigurationIntent) -> Currency? {
        let widgetData = loadWidgetData()
        let company = widgetData.companies[widgetData.companyId];
        let currency = company?.currencies[company!.currencyId];
        return Currency(identifier: currency!.id, display: currency!.name)
    }

    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
