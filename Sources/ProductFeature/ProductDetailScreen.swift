//
//  ProductDetailScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
import SharedServices
import SwiftUI
import SwiftUIHelpers

struct ProductDetailScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    @Environment(RouterService.self) private var router
    
    var item: Item
    
    // ============
    // MARK: - Body
    // ============
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image.getSafeImage(named: item.imageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    VStack(alignment: .leading) {
                        Text(item.name)
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background()
                }
            }
            .navigationTitle(item.name)
            .safeAreaInset(edge: .bottom) {
                bottomBar
            }
        }
    }
    
    private var bottomBar: some View {
        HStack(spacing: 32) {
            Button {
                // TODO: Add to Cart
            } label: {
                // TODO: Show badge number for items in cart
                Label("Add to Cart", systemImage: "cart")
            }
            .padding()
            
            Button {
                // TODO: Add to Cart
                // TODO: Mark selection
                router.productRoutes.append(.cart)
            } label: {
                Label("Buy now", systemImage: "dollarsign")
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.bar)
    }
}

#Preview {
    Group {
        NavigationStack {
            ProductDetailScreen(item: .mock)
        }
    }
    .environment(RouterService())
}
