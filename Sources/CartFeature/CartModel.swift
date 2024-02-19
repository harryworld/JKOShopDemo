//
//  CartModel.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
import Observation
import os.log

@Observable
public final class CartModel {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    let defaults = UserDefaults.standard
    
    private var cartItemIDs: [String] {
        get {
            guard let ids = defaults.object(forKey: "cartItemIDs") as? [String] else { return [] }
            return ids
        }
        set {
            defaults.set(newValue, forKey: "cartItemIDs")
            defaults.synchronize()
            
        }
    }
    
    var items: [CartItem] {
        didSet {
            cartItemIDs = items.map(\.item.id)
        }
    }
    var selectedItems: [CartItem] {
        items.filter(\.isChecked)
    }
    var totalPrice: Double {
        selectedItems.map(\.item.price).reduce(0, +)
    }
    var isCheckedAll: Bool { items.count == selectedItems.count }
    
    public var itemCount: Int { items.count }
    
    // ============
    // MARK: - Init
    // ============
    
    public init(items: [Item] = []) {
        self.items = items.map { CartItem(isChecked: false, item: $0) }
        
        Task {
            await fetchList()
        }
    }
    
    init(cartItems: [CartItem]) {
        self.items = cartItems
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    func fetchList() async {
        guard items.isEmpty,
              let ids = UserDefaults.standard.object(forKey: "cartItemIDs") as? [String]
        else { return }
        
        do {
            let items = try await DatabaseService.db.read { db in
                try Item.fetchAll(db, keys: ids)
            }
            self.items = items.map { CartItem(isChecked: false, item: $0) }
        } catch {
            Logger.database.error("\(error)")
        }
    }
    
    func selectAll() {
        items.forEach { $0.isChecked = true }
    }
    
    func deselectAll() {
        items.forEach { $0.isChecked = false }
    }
    
    public func addToCart(item: Item) {
        if items.contains(where: { $0.item.id == item.id }) {
            return
        }
        items.insert(CartItem(isChecked: true, item: item), at: 0)
    }
    
    public func submitOrder() {
        // Add to order list
        let ids = selectedItems.map(\.item.id)
        let price = selectedItems.map(\.item.price).reduce(0, +)
        Task {
            do {
                try await DatabaseService.db.write { db in
                    let order = Order(price: price)
                    let lineItems = ids.map { OrderLineItem(itemId: $0, orderId: order.id)}
                    try order.save(db)
                    for item in lineItems {
                        try item.save(db)
                    }
                }
            } catch {
                Logger.database.error("\(error)")
            }
        }
        
        // Clear cart
        let selectedIDs = selectedItems.map(\.item.id)
        items.removeAll(where: { selectedIDs.contains($0.id) })
    }
}

@Observable
class CartItem: Identifiable {
    var isChecked: Bool
    var item: Item
    
    var id: String { item.id }
    
    init(isChecked: Bool, item: Item) {
        self.isChecked = isChecked
        self.item = item
    }
}
