//
//  OrderModel.swift
//  JKOShop
//
//  Created by Harry Ng on 19/2/2024.
//

import Foundation
import Models
import Observation
import os.log

@Observable
final class OrderModel {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    var orders: [OrderInfo]
    var isDataLoading = false
    private var currentPage = 1
    private let itemsPerPage = 10 // Adjust based on the backend data

    // ============
    // MARK: - Init
    // ============
    
    init() {
        orders = []
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    func fetchList() {
        Task {
            do {
                self.orders = try await fetchPage()
            } catch {
                Logger.database.error("\(error)")
            }
        }
    }
    
    func resetPage() {
        self.currentPage = 1
    }
    
    func fetchNextPage() async {
        do {
            let count = try await DatabaseService.db.read { db in
                try Order.fetchCount(db)
            }
            
            guard orders.count < count else { return }
            guard !isDataLoading else { return }
            isDataLoading = true
            
            // Simulate network request
            try await Task.sleep(for: .seconds(1))
            
            self.currentPage += 1
            let newOrders = try await fetchPage()
            self.orders.append(contentsOf: newOrders)
            self.isDataLoading = false
        } catch {
            Logger.database.error("\(error)")
        }
    }
    
    private func fetchPage() async throws -> [OrderInfo] {
        let offset = (self.currentPage - 1) * self.itemsPerPage
        let limit = self.itemsPerPage
        let orders = try await DatabaseService.db.read { db in
            try OrderInfo.all()
                .limit(limit, offset: offset)
                .fetchAll(db)
        }
        return orders
    }
}
