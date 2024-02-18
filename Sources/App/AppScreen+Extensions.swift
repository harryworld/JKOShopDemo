//
//  AppScreen+Extensions.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import CartFeature
import OrderFeature
import ProductFeature
import SharedServices
import SwiftUI

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .product:
            Label {
                Text("Products", bundle: Bundle.module)
            } icon: {
                Image(systemName: "house")
            }
        case .cart:
            Label {
                Text("Cart", bundle: Bundle.module)
            } icon: {
                Image(systemName: "cart")
            }
        case .order:
            Label {
                Text("Orders", bundle: Bundle.module)
            } icon: {
                Image(systemName: "doc.fill")
            }
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .product:
            ProductListScreen()
        case .cart:
            CartWrapperScreen()
        case .order:
            OrderListScreen()
        }
    }
}
