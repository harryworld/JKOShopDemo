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
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.productRoutes) {
            List {
                ForEach(Item.all()) { item in
                    NavigationLink(value: ProductRoute.productDetail(item)) {
                        ItemRow(item: item)
                    }
                }
            }
            .navigationTitle("Products")
            .navigationDestination(for: ProductRoute.self) { route in
                switch route {
                case .productDetail(let item):
                    ProductDetailScreen(item: item)
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
    ProductListScreen()
        .environment(RouterService())
}
