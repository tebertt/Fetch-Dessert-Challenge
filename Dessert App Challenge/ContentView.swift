//
//  ContentView.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dessertList: [Dessert] = []
    
    var body: some View {
        NavigationSplitView {
            List(dessertList, id: \.self) { dessert in
                NavigationLink {
                    DessertDetailView(dessertID: dessert.id)
                } label: {
                    DessertListRow(dessert: dessert)
                }
            }
                .toolbar {
                    Button {
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            
        } detail: {
            Text("Hello")
        }
        .padding()
        .task {
            await doLoad()
        }
    }
    
    @Sendable func doLoad() async {
        
        let dessertManager = DessertManager()
        
        let dessertResult = await dessertManager.listDesserts()
        switch dessertResult {
            case .success(let desserts):
                self.dessertList = desserts.meals
            case .failure(let error):
                print(error)
        }
    }
}

#Preview {
    ContentView()
}
