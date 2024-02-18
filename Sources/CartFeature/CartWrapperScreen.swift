//
//  CartWrapperScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation
import SharedServices
import SwiftUI

public struct CartWrapperScreen: View {
    
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
        
        NavigationStack(path: $router.cartRoutes) {
            CartScreen()
                .navigationTitle(Text("Cart", bundle: Bundle.module))
                .navigationDestination(for: ProductRoute.self) { route in
                    switch route {
                    case .cartConfirm:
                        CartConfirmScreen()
                            .toolbar(.hidden, for: .tabBar)
                    default:
                        EmptyView()
                    }
                }
        }
    }
}

#Preview {
    CartWrapperScreen()
        .environment(RouterService())
        .environment(CartModel())
}
