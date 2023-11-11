//
//  DessertListRow.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/10/23.
//

import SwiftUI

struct DessertListRow: View {

    var dessert: Dessert

    var body: some View {

        HStack {

            AsyncImage(url: URL(string: dessert.thumbnail)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 50, height: 50)

            Text(dessert.name)
            Spacer()

        }

    }

}


