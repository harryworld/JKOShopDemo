//
//  ProductListScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import CartFeature
import Foundation
import ItemRowFeature
import Models
import SharedServices
import SwiftUI

public struct ProductListScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    @Environment(RouterService.self) private var router
    
    @State private var model: ProductModel
    
    // ============
    // MARK: - Init
    // ============
    
    public init(items: [Item] = []) {
        self._model = State(wrappedValue: ProductModel(items: items))
    }
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.productRoutes) {
            List {
                ForEach(model.items) { item in
                    NavigationLink(value: ProductRoute.productDetail(item)) {
                        ItemRow(item: item)
                    }
                    .onAppear {
                        // Demonstrate Paging
                        if item == model.items.last {
                            Task {
                                await model.fetchNextPage()
                            }
                        }
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
            .task {
                await model.fetchList()
            }
            .navigationTitle(Text("Products", bundle: Bundle.module))
            .navigationDestination(for: ProductRoute.self) { route in
                switch route {
                case .productDetail(let item):
                    ProductDetailScreen(item: item)
                        .toolbar(.hidden, for: .tabBar)
                case .cart:
                    CartScreen()
                case .cartConfirm:
                    CartConfirmScreen()
                }
            }
        }
    }
}

#Preview {
    ProductListScreen(items: Item.all())
        .environment(RouterService())
        .environment(CartModel())
}
