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
    
    @State private var model = OrderModel()
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        Group {
            if model.orders.isEmpty {
                emptyView
            } else {
                listView
            }
        }
        .onAppear(perform: model.updateOrders)
    }
    
    @ViewBuilder
    private var listView: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.orderRoutes) {
            List {
                ForEach(model.orders) { order in
                    NavigationLink(value: OrderRoute.orderDetail(order)) {
                        OrderRow(order: order)
                    }
                }
            }
            .navigationTitle(Text("Orders", bundle: Bundle.module))
            .navigationDestination(for: OrderRoute.self) { route in
                switch route {
                case .orderDetail(let order):
                    OrderDetailScreen(order: order)
                }
            }
        }
    }
    
    private var emptyView: some View {
        NavigationStack {
            ContentUnavailableView {
                Label {
                    Text("You don't have any order yet", bundle: Bundle.module)
                } icon: {
                    Image(systemName: "tray.fill")
                }
            } actions: {
                Button {
                    router.productRoutes = []
                    router.selection = .product
                } label: {
                    Text("Go shopping", bundle: Bundle.module)
                }
            }
            .navigationTitle(Text("Orders", bundle: Bundle.module))
        }
    }
}

#Preview {
    OrderListScreen()
        .environment(RouterService())
}
