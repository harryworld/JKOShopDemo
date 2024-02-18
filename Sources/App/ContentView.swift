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
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(RouterService())
        .environment(CartModel())
}
