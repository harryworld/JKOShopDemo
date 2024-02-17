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
    
    @State var selection: AppScreen
    
    // ============
    // MARK: - Init
    // ============
    
    public init(selection: AppScreen = .product) {
        self._selection = State(wrappedValue: selection)
    }
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        TabView(selection: $selection) {
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
