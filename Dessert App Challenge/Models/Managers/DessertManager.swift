//
//  DessertManager.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/9/23.
//

import Foundation
import SwiftUI

class DessertManager {
    
    private let loader: JSONLoader = JSONLoader()
    
    // Builds HTTP request, deocdes, returns Dessert Container with list of desserts
    public func listDesserts() async -> Result<DessertContainer, Error> {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let requestBuilder = RequestBuilder(url: url)
            .setMethod(method: .GET)
        
        return await loader.doRequest(request: requestBuilder)
    }
    
    // Builds HTTP request, deocdes, returns Dessert Container with list of desserts
    public func getDessertDetail(mealID: String) async -> Result<DessertDetailContainer, Error> {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=" + mealID)!
        let requestBuilder = RequestBuilder(url: url)
            .setMethod(method: .GET)
        
        return await loader.doRequest(request: requestBuilder)
    }
    
}
