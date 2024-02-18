//
//  JKOShopApp.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import App
import CartFeature
import Models
import SharedServices
import SwiftUI
import os.log

@main
struct JKOShopApp: App {
    
    // ============
    // MARK: - Init
    // ============
    
    init() {
        do {
            try DatabaseService.shared.migrate()
        } catch {
            Logger.database.error("\(error)")
        }
    }
    
    // ============
    // MARK: - Body
    // ============
    
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
