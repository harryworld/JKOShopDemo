//
//  JKOShopApp.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import App
import CartFeature
import SharedServices
import SwiftUI

@main
struct JKOShopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(RouterService())
                .environment(CartModel())
        }
    }
}

#Preview {
    ContentView()
        .environment(
            RouterService(
                selection: .order,
                orderRoutes: [.orderDetail(
                    .mock
                )]
            )
        )
        .environment(CartModel())
}
