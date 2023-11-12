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
        NavigationStack {
            List(dessertList, id: \.self) { dessert in
                NavigationLink {
                    DessertDetailView(dessertID: dessert.id)
                } label: {
                    DessertListRow(dessert: dessert)
                }
            }
            .navigationTitle("Desserts")
            .toolbar {
                Button {
                    Task {
                        await doLoad()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .refreshable {
                await doLoad()
            }
        }

        .task {
            await doLoad()
        }
    }

    // Asynchronous function to load dessert list
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
