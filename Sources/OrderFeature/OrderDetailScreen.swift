//
//  OrderDetailScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation
import ItemRowFeature
import Models
import SwiftUI

struct OrderDetailScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    var order: Order
    
    // ============
    // MARK: - Body
    // ============
    
    var body: some View {
        List {
            ForEach(order.items) { item in
                HStack(spacing: 8) {
                    ItemRow(item: item)
                }
                .padding(.horizontal, 4)
            }
            
            HStack {
                Text("\(order.items.count) items", bundle: Bundle.module)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Total: $\(order.totalPrice, specifier: "%.0f")", bundle: Bundle.module)
                    .lineLimit(1)
            }
        }
        .navigationTitle(Text("Order Detail", bundle: Bundle.module))
    }
}

#Preview {
    NavigationStack {
        OrderDetailScreen(order: .mock)
    }
}
