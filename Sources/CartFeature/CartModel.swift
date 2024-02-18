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
            items = Item.all()
                .filter { ids.contains($0.id) }
                .map { CartItem(isChecked: false, item: $0) }
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
        items.append(CartItem(isChecked: true, item: item))
    }
    
    public func submitOrder() {
        // TODO: Add to order list
        items.removeAll()
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
