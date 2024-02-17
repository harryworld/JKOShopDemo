//
//  JKOShopApp.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import App
import SharedServices
import SwiftUI

@main
struct JKOShopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(RouterService())
        }
    }
}

#Preview {
    ContentView()
        .environment(RouterService())
}
