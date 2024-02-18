//
//  CartScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import ItemRowFeature
import Models
import SharedServices
import SwiftUI
import SwiftUIHelpers

public struct CartScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    @Environment(CartModel.self) private var cartModel
    @Environment(RouterService.self) private var router
    
    @State private var isCheckedAll = false
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        if cartModel.items.isEmpty {
            emptyView
        } else {
            listView
        }
    }
    
    private var listView: some View {
        List {
            ForEach(cartModel.items) { item in
                @Bindable var item = item
                HStack(spacing: 8) {
                    Toggle(isOn: $item.isChecked) {}
                        .toggleStyle(iOSCheckboxToggleStyle())
                        .padding(.leading, -8)
                        .onChange(of: item.isChecked) { _, _ in
                            updateSelectAllToggle()
                        }
                    ItemRow(item: item.item)
                }
                .padding(.horizontal, 4)
                .contentShape(.containerRelative)
                .onTapGesture {
                    item.isChecked.toggle()
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        withAnimation {
                            cartModel.items.removeAll(where: { $0.id == item.id })
                        }
                    } label: {
                        Label {
                            Text("Remove")
                        } icon: {
                            Image(systemName: "trash")
                        }
                    }
                    .tint(.red)
                }
            }
        }
        .navigationTitle("Cart")
        .safeAreaInset(edge: .bottom) {
            bottomBar
        }
    }
    
    private var bottomBar: some View {
        HStack {
            Button {
                if isCheckedAll {
                    cartModel.deselectAll()
                } else {
                    cartModel.selectAll()
                }
            } label: {
                Label("Select all", systemImage: isCheckedAll ? "checkmark.square" : "square")
            }
            .buttonStyle(.plain)
            .onAppear {
                updateSelectAllToggle()
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Text("Total $\(cartModel.totalPrice, specifier: "%.2f")")
                
                NavigationLink(value: ProductRoute.cartConfirm) {
                    Text("Checkout")
                }
                .disabled(cartModel.selectedItems.isEmpty)
            }
        }
        .padding()
        .background(.bar)
    }
    
    private var emptyView: some View {
        ContentUnavailableView {
            Label("You don't have any item in the cart", systemImage: "tray.fill")
        } actions: {
            Button {
                router.productRoutes = []
                router.selection = .product
            } label: {
                Text("Go shopping")
            }
        }
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    private func updateSelectAllToggle() {
        isCheckedAll = cartModel.isCheckedAll
    }
}

#Preview {
    NavigationStack {
        CartScreen()
    }
    .environment(RouterService())
    .environment(CartModel(items: [.mock]))
}
