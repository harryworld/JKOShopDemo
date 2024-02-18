//
//  ProductModel.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation
import Models
import Observation

@Observable
final class ProductModel {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    var items: [Item]
    var isDataLoading = false
    private var currentPage = 1
    private let itemsPerPage = 10 // Adjust based on the backend data
    
    // ============
    // MARK: - Init
    // ============
    
    init() {
        items = Array(Item.all().prefix(upTo: 10))
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    func fetchNextPage() {
        guard items.count < Item.all().count else { return }
        guard !isDataLoading else { return }
        isDataLoading = true
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let start = self.currentPage * self.itemsPerPage
            let offset = self.currentPage * self.itemsPerPage + self.itemsPerPage
            let end = min(offset, Item.all().count)
            let newItems = Array(Item.all()[start..<end])
            self.items.append(contentsOf: newItems)
            self.currentPage += 1
            self.isDataLoading = false
        }
    }
}
