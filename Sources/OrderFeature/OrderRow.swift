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
    
    let info: OrderInfo
    
    // ============
    // MARK: - Init
    // ============
    
    public init(info: OrderInfo) {
        self.info = info
    }
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        VStack {
            HStack(alignment: .top) {
                let imageClipShape = RoundedRectangle(cornerRadius: 10, style: .continuous)
                Image.getSafeImage(named: info.coverImageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(imageClipShape)
                    .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
                
                VStack(alignment: .leading) {
                    Text(info.name)
                        .font(.headline)
                    Text(info.description)
                        .lineLimit(1)
                        .foregroundStyle(.secondary)
                }
                
                Spacer(minLength: 0)
            }
            .font(.subheadline)
            
            Divider()
            
            HStack {
                Text("\(info.items.count) items", bundle: Bundle.module)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Total: $\(info.order.price, specifier: "%.0f")", bundle: Bundle.module)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    OrderRow(info: .mock)
        .padding(.horizontal)
}
