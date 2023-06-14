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
        
        // 2
        // Transform `[Asset]` to `[Crypto]`
        /*
        let cryptos = assets.map { asset in
            
            let crypto = Crypto(
                identifier: asset.id,
                display: "\(asset.name) (\(asset.symbol))"
            )
            crypto.symbol = asset.symbol
            crypto.name = asset.name
            
            return crypto
        }
        */
        
        // 3
        // Create a collection with the array of cryptos.
        let company1 = Company(identifier: "1", display: "Test 1")
        let company2 = Company(identifier: "2", display: "Test 2")

        let collection = INObjectCollection(items: [company1, company2])
        
        // Return the collections
        return collection
        
    }

    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
