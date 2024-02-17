//
//  ItemRow.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
import SwiftUI
import SwiftUIHelpers

/// Row of the product list, also demonstrate the `Container Pattern`
public struct ItemRow: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    let item: Item
    
    // ============
    // MARK: - Init
    // ============
    
    public init(item: Item) {
        self.item = item
    }
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        HStack(alignment: .top) {
            let imageClipShape = RoundedRectangle(cornerRadius: 10, style: .continuous)
            Image.getSafeImage(named: item.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(imageClipShape)
                .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.description)
                    .lineLimit(2)
                
                Text("$\(item.price, specifier: "%.2f")")
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            
            Spacer(minLength: 0)
        }
        .font(.subheadline)
    }
}

#Preview {
    ItemRow(
        item: Item(
            name: "Naturehike 6.1",
            description: "This is such a good tent. You can try it out here and there.",
            price: 250,
            imageUrl: "",
            createdAt: Date()
        )
    )
    .frame(width: 300, alignment: .leading)
    .padding(.horizontal)
    .previewLayout(.sizeThatFits)
}
