//
//  CartModel.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
import Observation

@Observable
public final class CartModel {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    private var cartItemIDs: [String] {
        get {
            guard let ids = UserDefaults.standard.object(forKey: "cartItemIDs") as? [String] else { return [] }
            return ids
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "cartItemIDs")
        }
    }
    private var orders: [String: [String]] {
        get {
            guard let orders = UserDefaults.standard.object(forKey: "orders") as? [String: [String]] else { return [:] }
            return orders
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "orders")
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
    
    public init() {
        if let ids = UserDefaults.standard.object(forKey: "cartItemIDs") as? [String] {
            let products = Item.all()
            items = ids.compactMap { id in
                if let product = products.first(where: { $0.id == id }) {
                    return CartItem(isChecked: false, item: product)
                } else {
                    return nil
                }
            }
        } else {
            items = []
        }
    }
    
    public init(items: [Item]) {
        self.items = items.map { CartItem(isChecked: false, item: $0) }
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
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
        orders[UUID().uuidString] = selectedItems.map(\.id)
        
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
