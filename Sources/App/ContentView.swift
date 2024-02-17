//
//  ContentView.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import CartFeature
import ProductFeature
import SharedServices
import SwiftUI

public struct ContentView: View {
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        ProductListScreen()
    }
}

#Preview {
    ContentView()
        .environment(RouterService())
        .environment(CartModel())
}
