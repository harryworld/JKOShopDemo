//
//  ContentView.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import CartFeature
import SharedServices
import SwiftUI

public struct ContentView: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    @Environment(RouterService.self) private var router
    @Environment(CartModel.self) private var cartModel
    
    // ============
    // MARK: - Init
    // ============
    
    public init() { }
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        @Bindable var router = router
        
        TabView(selection: $router.selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen)
                    .tabItem { screen.label }
                    .badge(badge(for: screen))
            }
        }
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    private func badge(for screen: AppScreen) -> Int {
        switch screen {
        case .cart:
            return cartModel.itemCount
        default:
            return 0
        }
    }
}

#Preview {
    ContentView()
        .environment(RouterService())
        .environment(CartModel())
}
