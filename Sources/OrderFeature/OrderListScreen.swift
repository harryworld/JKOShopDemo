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
        .onAppear(perform: model.fetchList)
        .onDisappear(perform: model.resetPage)
    }
    
    @ViewBuilder
    private var listView: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.orderRoutes) {
            List {
                ForEach(model.orders) { info in
                    NavigationLink(value: OrderRoute.orderDetail(info)) {
                        OrderRow(info: info)
                    }
                    .onAppear {
                        // Demonstrate Paging
                        if info == model.orders.last {
                            Task {
                                await model.fetchNextPage()
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Orders", bundle: Bundle.module))
            .navigationDestination(for: OrderRoute.self) { route in
                switch route {
                case .orderDetail(let info):
                    OrderDetailScreen(info: info)
                }
            }
            
            // Show Loading
            if model.isDataLoading {
                HStack {
                    Spacer()
                    Text("Loading", bundle: Bundle.module)
                    Spacer()
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
