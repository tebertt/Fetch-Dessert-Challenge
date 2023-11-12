//
//  DessertDetailCodable.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/11/23.
//

import Foundation

struct DessertDetail: Codable {
    
    var name: String
    var id: String
    var instructions: String
    var ingredients: [Int:String]
    var measurements: [Int:String]
    
}

extension DessertDetail {
    // CodingKey used for dynamic keys
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
    
    // Empty init
    init() {
        self.name = ""
        self.id = ""
        self.instructions = ""
        self.ingredients = [:]
        self.measurements = [:]
    }
    
    // Full decoder init
    init(from decoder: Decoder) throws {
        
        // Init variables
        self.name = ""
        self.id = ""
        self.instructions = ""
        ingredients = [Int:String]()
        measurements = [Int:String]()
        
        // Find values for keys
        let container = try decoder.container(keyedBy: DynamicKeys.self)
        for key in container.allKeys {
            do {
                let item = try container.decode(String.self, forKey: key)
                if key.stringValue.hasPrefix("strIngredient") {
                    if(!(item.isEmpty)) {
                        // Get the index of current key
                        let num = key.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        // Put into hash table
                        ingredients[Int(num)!] = item
                    }
                } else if key.stringValue.hasPrefix("strMeasure") {
                    if(!(item.isEmpty) || item == " ") {
                        // Get the index of current key
                        let num = key.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        // Put into hash table
                        measurements[Int(num)!] = item
                    }
                }
                
                // Replaces need of CodingKeys
                if key.stringValue == "idMeal" {
                    self.id = item
                } else if key.stringValue == "strInstructions" {
                    self.instructions = item
                } else if key.stringValue == "strMeal" {
                    self.name = item
                }
            } catch {
                // If value is null go here
            }
            
        }
        
    }
    
}

struct DessertDetailContainer: Codable {
    var meals : [DessertDetail]
}
