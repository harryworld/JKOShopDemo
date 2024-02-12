//
//  Item.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import Foundation

struct Item: Identifiable {
    let id: String
    var name: String
    var description: String
    var price: Double
    var imageUrl: String
    var createdAt: Date

    init(
        id: String = UUID().uuidString,
        name: String,
        description: String,
        price: Double,
        imageUrl: String,
        createdAt: Date
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.imageUrl = imageUrl
        self.createdAt = createdAt
    }
}
