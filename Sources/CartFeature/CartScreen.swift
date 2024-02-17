//
//  CartScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import SwiftUI

public struct CartScreen: View {
    
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
        VStack {
            Text("Cart")
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    CartScreen()
}
