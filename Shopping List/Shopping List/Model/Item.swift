//
//  Item.swift
//  Shopping List
//
//  Created by Olexsii Levchenko on 5/20/22.
//

import UIKit

struct Item: Hashable {
    let name: String
    let price: Double
    let category: Category
    let identifier = UUID()
    
    //implement the hashable property for Item
    //Hasher is the hash function in Swift
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func testData() -> [Item]{
        return [
            Item(name: "Polar Bluetooth", price: 23.99, category: .running),
            Item(name: "Honey Stinger Organic Gluten", price: 23.10, category: .running),
            Item(name: "Saucony Men's Spring Elite Singlet", price: 23.7, category: .running),
            Item(name: "The Complete iOS App Development Bootcamp", price: 73.89, category: .education),
            Item(name: "The course of lectures: CS50", price: 53.50, category: .education),
            Item(name: "GitHub Followers - Take Home Project", price: 223.20, category: .education),
            Item(name: "California Gold Nutrition, Gold C", price: 23.50, category: .health),
            Item(name: "Optimum Nutrition Gold Standard", price: 23.50, category: .health),
            Item(name: "Power Super Foods Maca Power", price: 23.50, category: .health),
            Item(name: "Bread", price: 63.58, category: .household),
            Item(name: "Pasta", price: 93.50, category: .household),
            Item(name: "Rice", price: 24.50, category: .household),
            Item(name: "MacBook Pro 14", price: 28.50, category: .technology),
            Item(name: "IPhone 13", price: 12.58, category: .technology),
            Item(name: "AirTag", price: 99.8, category: .technology),
            Item(name: "Zone3 Junior Adventure Wetsuit", price: 523.50, category: .traithlon),
            Item(name: "Vitus Nucleus 29 VRS", price: 283.50, category: .traithlon),
            Item(name: "2XU Womens Aero 7", price: 239.50, category: .traithlon),
            Item(name: "Rx-Swift Book", price: 243.90, category: .education),
            Item(name: "Shimano SH-TR901 Shoes", price: 283.50, category: .shoppingCart)
        ]
    }
}
