//
//  Order.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import Foundation

struct Order: Identifiable {
    let id: String
    var items: [Item]
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    var createdAt: Date

    init(
        id: String = UUID().uuidString,
        items: [Item],
        createdAt: Date
    ) {
        self.id = id
        self.items = items
        self.createdAt = createdAt
    }
}
