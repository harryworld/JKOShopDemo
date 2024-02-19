//
//  ProductModel.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation
import Models
import Observation
import os.log

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
    
    init(items: [Item] = []) {
        self.items = items
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    func fetchList() async {
        guard items.isEmpty else { return }
        
        do {
            self.items = try await fetchPage()
        } catch {
            Logger.database.error("\(error)")
        }
    }
    
    func fetchNextPage() async {
        do {
            let count = try await DatabaseService.db.read { db in
                try Item.fetchCount(db)
            }
            
            guard items.count < count else { return }
            guard !isDataLoading else { return }
            isDataLoading = true
            
            // Simulate network request
            try await Task.sleep(for: .seconds(1))
            
            self.currentPage += 1
            let newItems = try await fetchPage()
            self.items.append(contentsOf: newItems)
            self.isDataLoading = false
        } catch {
            Logger.database.error("\(error)")
        }
    }
    
    private func fetchPage() async throws -> [Item] {
        let offset = (self.currentPage - 1) * self.itemsPerPage
        let limit = self.itemsPerPage
        let items = try await DatabaseService.db.read { db in
            try Item.limit(limit, offset: offset).fetchAll(db)
        }
        return items
    }
}
