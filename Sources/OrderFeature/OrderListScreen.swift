//
//  OrderListScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation
import Models
import SharedServices
import SwiftUI

public struct OrderListScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    @Environment(RouterService.self) private var router
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.orderRoutes) {
            List {
                ForEach(Order.all()) { order in
                    NavigationLink(value: OrderRoute.orderDetail(order)) {
                        OrderRow(order: order)
                    }
                }
            }
            .navigationTitle("Orders")
            .navigationDestination(for: OrderRoute.self) { route in
                switch route {
                case .orderDetail(let order):
                    OrderDetailScreen(order: order)
                }
            }
        }
    }
}

#Preview {
    OrderListScreen()
        .environment(RouterService())
}
