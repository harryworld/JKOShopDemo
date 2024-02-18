//
//  OrderPlacedScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation
import SharedServices
import SwiftUI

struct OrderPlacedScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    @Environment(\.dismiss) private var dismiss
    @Environment(RouterService.self) private var router
    
    // ============
    // MARK: - Body
    // ============
    
    var body: some View {
        VStack {
            card
            
            Button("Back to Home") {
                dismiss()
                router.productRoutes = []
                router.cartRoutes = []
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
        }
    }
    
    private var card: some View {
        VStack {
            Text("Thank you for your order!")
                .font(.title.bold())
                .textCase(.uppercase)
                .layoutPriority(1)
            Text("We will deliver your order shortly.")
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 36)
        .frame(width: 300, height: 300)
        .background(in: Circle())
    }
}

#Preview {
    NavigationStack {
        OrderPlacedScreen()
    }
    .environment(RouterService())
}

