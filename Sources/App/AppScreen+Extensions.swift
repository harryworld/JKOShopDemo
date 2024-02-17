//
//  AppScreen+Extensions.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import OrderFeature
import ProductFeature
import SharedServices
import SwiftUI

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .product:
            Label("Products", systemImage: "house")
        case .order:
            Label("Orders", systemImage: "cart")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .product:
            ProductListScreen()
        case .order:
            OrderListScreen()
        }
    }
}
