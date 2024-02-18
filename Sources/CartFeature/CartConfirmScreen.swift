//
//  CartConfirmScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import ItemRowFeature
import SharedServices
import SwiftUI

public struct CartConfirmScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    @Environment(CartModel.self) private var cartModel
    
    @State private var isShowingOrderPlaced = false
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        List {
            ForEach(cartModel.items) { item in
                @Bindable var item = item
                HStack(spacing: 8) {
                    ItemRow(item: item.item)
                }
                .padding(.horizontal, 4)
            }
        }
        .navigationTitle(Text("Confirm Order", bundle: Bundle.module))
        .safeAreaInset(edge: .bottom) {
            bottomBar
        }
    }
    
    private var bottomBar: some View {
        HStack {
            Spacer()
            
            HStack(spacing: 8) {
                Text("Total $\(cartModel.totalPrice, specifier: "%.2f")", bundle: Bundle.module)
                
                Button {
                    // TODO: Submit order
                    cartModel.submitOrder()
                    isShowingOrderPlaced = true
                } label: {
                    Text("Submit", bundle: Bundle.module)
                }
            }
        }
        .padding()
        .background(.bar)
        .sheet(isPresented: $isShowingOrderPlaced) {
            OrderPlacedScreen()
        }
    }
}

#Preview {
    NavigationStack {
        CartConfirmScreen()
    }
    .environment(RouterService())
    .environment(CartModel())
}

