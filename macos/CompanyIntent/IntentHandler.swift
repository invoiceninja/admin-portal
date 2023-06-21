import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    private func loadWidgetData() -> WidgetData {
        let sharedDefaults = UserDefaults(suiteName: "group.com.invoiceninja.app")
        var exampleData: WidgetData = WidgetData(url: "", companies: [:])

        if let sharedDefaults = sharedDefaults {
            do {
                if let shared = sharedDefaults.string(forKey: "widget_data") {
                    let decoder = JSONDecoder()
                    exampleData = try decoder.decode(WidgetData.self, from: shared.data(using: .utf8)!)
                }
            } catch {
                print(error)
            }
        }
        
        return exampleData
    }
    
    func provideCompanyOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<Company> {
        let exampleData = loadWidgetData()
        
        let companies = exampleData.companies.values.map { company in
            Company(identifier: company.id, display: company.name)
        }
        
        return INObjectCollection(items: companies)
    }
    
    //func defaultCompany(for intent: ConfigurationIntent) -> Company? {}
    
    func provideCurrencyOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<Currency> {
        let exampleData = loadWidgetData()
        
        let company = exampleData.companies[(intent.company?.identifier!)!]
        let currencies = company!.currencies.values.map { currency in
            Currency(identifier: currency.id, display: currency.name)
        }
        
        return INObjectCollection(items: currencies)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
