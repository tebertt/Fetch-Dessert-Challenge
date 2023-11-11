//
//  DessertDetailView.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/10/23.
//

import Foundation
import SwiftUI

struct DessertDetailView: View {
    
    @State var dessertID: String
    @State private var dessert: DessertDetail = DessertDetail()
    
    var body: some View {
        List {
            Section(header: Text("Instructions")) {
                Text("\(dessert.instructions)")
            }
            Section(header: Text("Ingredients")) {
                ForEach(dessert.ingredients.sorted(by: <), id: \.key) { index, ingredient in
                    if(dessert.measurements[index] != nil) {
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Text(dessert.measurements[index]!)
                        }
                    }
                }
            }
        }
        .task {
            await doLoad()
        }
    }
    
    @Sendable func doLoad() async {
        
        let dessertManager = DessertManager()
        
        let dessertResult = await dessertManager.getDessertDetail(mealID: dessertID)
        switch dessertResult {
            case .success(let dessert):
                self.dessert = dessert.meals[0]
            case .failure(let error):
                print(error)
        }
    }
    
}
