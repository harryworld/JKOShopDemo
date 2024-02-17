//
//  CartModel.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Models
import Observation

@Observable
public final class CartModel {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    var items: [CartItem]
    var selectedItems: [CartItem] {
        items.filter(\.isChecked)
    }
    var totalPrice: Double {
        selectedItems.map(\.item.price).reduce(0, +)
    }
    var isCheckedAll: Bool { items.count == selectedItems.count }
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {
        // TODO: Fetch items from Cart
        items = Item.all().map { CartItem(isChecked: false, item: $0) }
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
