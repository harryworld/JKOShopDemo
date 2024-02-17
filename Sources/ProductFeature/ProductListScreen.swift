//
//  ProductListScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
import SharedServices
import SwiftUI

public struct ProductListScreen: View {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(Item.all()) { item in
                    NavigationLink(value: ProductRoute.productDetail(item)) {
                        ItemRow(item: item)
                    }
                }
            }
            .navigationTitle("Products")
            .navigationDestination(for: ProductRoute.self) { route in
                switch route {
                case .productDetail(let item):
                    ProductDetailScreen(item: item)
                }
            }
        }
    }
}

#Preview {
    ProductListScreen()
}
