//
//  ProductDetailScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import CartFeature
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
    @Environment(CartModel.self) private var cartModel
    
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
                        Text("$\(item.price, specifier: "%.2f")")
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: ProductRoute.cart) {
                        Image(systemName: "cart")
                    }
                    .overlay {
                        NotificationCountView(value: .constant(cartModel.itemCount))
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                bottomBar
            }
        }
    }
    
    private var bottomBar: some View {
        HStack(spacing: 32) {
            Button {
                cartModel.addToCart(item: item)
            } label: {
                Label {
                    Text("Add to Cart", bundle: Bundle.module)
                } icon: {
                    Image(systemName: "cart")
                }
            }
            .padding()
            
            Button {
                cartModel.addToCart(item: item)
                router.productRoutes.append(.cart)
            } label: {
                Label {
                    Text("Buy now", bundle: Bundle.module)
                } icon: {
                    Image(systemName: "dollarsign")
                }
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
    .environment(CartModel(items: [.mock]))
}
