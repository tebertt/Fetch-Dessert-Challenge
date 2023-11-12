//
//  Dessert_App_ChallengeTests.swift
//  Dessert App ChallengeTests
//
//  Created by Troy Ebert on 11/9/23.
//

import XCTest
@testable import Dessert_App_Challenge

final class Dessert_App_ChallengeTests: XCTestCase {
    func testDessertsDecoding() {

        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Desserts", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                print("Failed to open Desserts.json")
                return
        }
        
        let loader = JSONLoader()
        guard let desserts: DessertContainer = loader.decode(data: data) else {
            // If failed to decode
            print(ServerError.requestFailure(message: "Failure to decode JSON"))
            return
        }
        
        XCTAssertEqual(desserts.meals[0].name, "Apam balik")
        XCTAssertEqual(desserts.meals[0].thumbnail, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        XCTAssertEqual(desserts.meals[0].id, "53049")
        
        XCTAssertEqual(desserts.meals[1].name, "Apple & Blackberry Crumble")
        XCTAssertEqual(desserts.meals[1].thumbnail, "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")
        XCTAssertEqual(desserts.meals[1].id, "52893")
        
        XCTAssertEqual(desserts.meals[2].name, "Apple Frangipan Tart")
        XCTAssertEqual(desserts.meals[2].thumbnail, "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")
        XCTAssertEqual(desserts.meals[2].id, "52768")
        
        XCTAssertEqual(desserts.meals[3].name, "Bakewell tart")
        XCTAssertEqual(desserts.meals[3].thumbnail, "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg")
        XCTAssertEqual(desserts.meals[3].id, "52767")
        
        XCTAssertEqual(desserts.meals[4].name, "Banana Pancakes")
        XCTAssertEqual(desserts.meals[4].thumbnail, "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg")
        XCTAssertEqual(desserts.meals[4].id, "52855")
    }
    
    func testDessertDetailDecoding() {
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Dessert", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                print("Failed to open Desserts.json")
                return
        }
        
        let loader = JSONLoader()
        guard let dessert: DessertDetailContainer = loader.decode(data: data) else {
            // If failed to decode
            print(ServerError.requestFailure(message: "Failure to decode JSON"))
            return
        }
        
        XCTAssertEqual(dessert.meals[0].name, "Budino Di Ricotta")
        XCTAssertEqual(dessert.meals[0].instructions, "Mash the ricotta and beat well with the egg yolks, stir in the flour, sugar, cinnamon, grated lemon rind and the rum and mix well. You can do this in a food processor. Beat the egg whites until stiff, fold in and pour into a buttered and floured 25cm cake tin. Bake in the oven at 180ºC/160ºC fan/gas 4 for about 40 minutes, or until it is firm.\r\n\r\nServe hot or cold dusted with icing sugar.")
        XCTAssertEqual(dessert.meals[0].id, "52961")
    }
}
