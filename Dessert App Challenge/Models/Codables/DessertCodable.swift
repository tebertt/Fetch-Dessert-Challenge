//
//  DessertCodable.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/9/23.
//

import Foundation

struct Dessert: Codable, Hashable {
    
    var name: String
    var thumbnail: String
    var id: String
}

// Coding keys
extension Dessert {
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case id = "idMeal"
    }
}

// Container for Dessert JSON Struct
struct DessertContainer: Codable {
    var meals : [Dessert]
}

