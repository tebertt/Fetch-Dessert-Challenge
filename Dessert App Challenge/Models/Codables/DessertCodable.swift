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
    
    private enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case id = "idMeal"
    }
}

struct DessertContainer: Codable {
    var meals : [Dessert]
}

struct DessertDetailContainer: Codable {
    var meals : [DessertDetail]
}

struct DessertDetail: Codable {
    
    var name: String
    var id: String
    var instructions: String
    var ingredients: [Int:String]
    var measurements: [Int:String]

    struct DynamicKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init() {
        self.name = ""
        self.id = ""
        self.instructions = ""
        self.ingredients = [:]
        self.measurements = [:]
    }

    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicKeys.self)
        self.id = ""
        self.instructions = ""
        self.name = ""
        ingredients = [Int:String]()
        measurements = [Int:String]()
        for key in container.allKeys {
            do {
                let item = try container.decode(String.self, forKey: key)
                if key.stringValue.hasPrefix("strIngredient") {
                    if(!(item.isEmpty)) {
                        // Get the index of
                        let num = key.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

                        ingredients[Int(num)!] = item
                    }
                } else if key.stringValue.hasPrefix("strMeasure") {
                    if(!(item.isEmpty) || item == " ") {
                        let num = key.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        measurements[Int(num)!] = item
                    }
                    
                } else if key.stringValue.hasPrefix("idMeal") {
                    self.id = item
                } else if key.stringValue.hasPrefix("strInstructions") {
                    self.instructions = item
                } else if key.stringValue.hasPrefix("strMeal") {
                    self.name = item
                }
            } catch {
                print("JSONDecoder: Null value")
            }
            
        }
        print(ingredients)
        print(measurements)
    }
    
}
