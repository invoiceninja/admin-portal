//
//  IntentHandler.swift
//  CompanyIntent
//
//  Created by hillel on 14/06/2023.
//

import Intents
import DashboardWidgetExtension

class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    func provideCompanyOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<Company> {
        
        // 1
        // Fetch list of top ten crypto from API
        //let assets = try await AssetFetcher.fetchTopTenAssets()
        

        
        let sharedDefaults = UserDefaults.init(suiteName: "group.com.invoiceninja.app")
        var exampleData: WidgetData = WidgetData(tokens:[:])

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
        
        let companies = exampleData.tokens.keys.map { token in
            
            let company = Company(
                identifier: token,
                display: exampleData.tokens[token] ?? ""
            )
            //company.symbol = asset.symbol
            //company.name = asset.name
            
            return company
        }
        
        // 3
        // Create a collection with the array of cryptos.
        //let company1 = Company(identifier: "1", display: "Test 1")
        //let company2 = Company(identifier: "2", display: "Test 2")
        //let collection = INObjectCollection(items: [company1, company2])
        
        let collection = INObjectCollection(items: companies)
        
        // Return the collections
        return collection
        
    }

    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
