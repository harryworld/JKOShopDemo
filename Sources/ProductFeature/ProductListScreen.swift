//
//  ProductListScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
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
        List {
            ForEach(Item.all()) { item in
                ItemRow(item: item)
            }
        }
    }
}

#Preview {
    ProductListScreen()
}
