//
//  OrderModel.swift
//  JKOShop
//
//  Created by Harry Ng on 19/2/2024.
//

import Foundation
import Models
import Observation

@Observable
final class OrderModel {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    var orders: [Order]
    
    // ============
    // MARK: - Init
    // ============
    
    init() {
        orders = []
    }
    
    func updateOrders() {
        if let dict = UserDefaults.standard.dictionary(forKey: "orders") as? [String: [String]] {
            let products = Item.all()
            orders = dict.map { key, ids in
                let items = ids.compactMap { id in
                    if let product = products.first(where: { $0.id == id }) {
                        return product
                    } else {
                        return nil
                    }
                }
                return Order(id: key, items: items, createdAt: Date())
            }
        }
    }
}
