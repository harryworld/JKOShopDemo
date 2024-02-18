//
//  OrderRow.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation
import Models
import SwiftUI
import SwiftUIHelpers

public struct OrderRow: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    let order: Order
    
    // ============
    // MARK: - Init
    // ============
    
    public init(order: Order) {
        self.order = order
    }
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        VStack {
            HStack(alignment: .top) {
                let imageClipShape = RoundedRectangle(cornerRadius: 10, style: .continuous)
                Image.getSafeImage(named: order.coverImageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(imageClipShape)
                    .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
                
                VStack(alignment: .leading) {
                    Text(order.name)
                        .font(.headline)
                    Text(order.description)
                        .lineLimit(1)
                        .foregroundStyle(.secondary)
                }
                
                Spacer(minLength: 0)
            }
            .font(.subheadline)
            
            Divider()
            
            HStack {
                Text("\(order.items.count) items", bundle: Bundle.module)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Total: $\(order.totalPrice, specifier: "%.0f")", bundle: Bundle.module)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    OrderRow(order: .mock)
        .padding(.horizontal)
}
