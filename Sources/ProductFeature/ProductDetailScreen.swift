//
//  ProductDetailScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
import SwiftUI
import SwiftUIHelpers

struct ProductDetailScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
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
            Button(action: {}) {
                Label("Add to Cart", systemImage: "cart")
            }
            .padding()
            
            Button(action: {}) {
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
}
