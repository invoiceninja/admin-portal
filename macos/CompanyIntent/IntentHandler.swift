import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    private func loadWidgetData() -> WidgetData {
        var widgetData: WidgetData = WidgetData(url: "",
                                                companyId: "",
                                                companies: [:],
                                                dateRanges: [:],
                                                dashboardFields: [:])
        
        do {
            widgetData = try getWidgetData()
        } catch {
            print(error)
        }
                
        return widgetData
    }
    
    func provideCompanyOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<Company> {
        let widgetData = loadWidgetData()
        
        let companies = widgetData.companies.keys.sorted().map { companyId in
            Company(identifier: companyId, display: widgetData.companies[companyId]!.name)
        }
        
        return INObjectCollection(items: companies)
    }
    
    func defaultCompany(for intent: ConfigurationIntent) -> Company? {
        let widgetData = loadWidgetData()
        
        if (widgetData.companyId.isEmpty) {
            return nil
        }
        
        let company = widgetData.companies[widgetData.companyId];
        return Company(identifier: company!.id, display: company!.name)
    }
    
    func provideCurrencyOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<Currency> {
        let widgetData = loadWidgetData()
        
        let company = widgetData.companies[(intent.company?.identifier!)!]
        let currencies = company!.currencies.keys.sorted().map { currencyId in
            Currency(identifier: currencyId, display: company!.currencies[currencyId]!.name)
        }
        
        return INObjectCollection(items: currencies)
    }
    
    func defaultCurrency(for intent: ConfigurationIntent) -> Currency? {
        let widgetData = loadWidgetData()
        
        if (widgetData.companyId.isEmpty) {
            return nil
        }

        let company = widgetData.companies[widgetData.companyId];
        let currency = company?.currencies[company!.currencyId];
        return Currency(identifier: currency!.id, display: currency!.name)
    }
    
    func provideDateRangeOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<DateRange> {
        let widgetData = loadWidgetData()
        
        
        let dateRanges = widgetData.dateRanges.keys.sorted().map { dateRange in
            DateRange(identifier: dateRange, display: widgetData.dateRanges[dateRange]!)
        }
        
        return INObjectCollection(items: dateRanges)
    }
    
    func defaultDateRange(for intent: ConfigurationIntent) -> DateRange? {
        let widgetData = loadWidgetData()
        
        if (widgetData.dateRanges.isEmpty) {
            return nil
        }

        let defaultDateRange = "last30_days";
        let dateRamge = widgetData.dateRanges[defaultDateRange]!;
        return DateRange(identifier: defaultDateRange, display: dateRamge)
    }

    func provideDashboardFieldOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<DashboardField> {
        let widgetData = loadWidgetData()
        
        
        let fields = widgetData.dashboardFields.keys.sorted().map { field in
            DashboardField(identifier: field, display: widgetData.dashboardFields[field]!)
        }
        
        return INObjectCollection(items: fields)
    }
    
    func defaultDashboardField(for intent: ConfigurationIntent) -> DashboardField? {
        let widgetData = loadWidgetData()
        
        if (widgetData.dashboardFields.isEmpty) {
            return nil
        }

        let defaultField = "total_active_invoices";
        let field = widgetData.dashboardFields[defaultField]!;
        return DashboardField(identifier: defaultField, display: field)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
