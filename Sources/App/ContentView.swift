//
//  ContentView.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import Models
import SwiftUI

public struct ContentView: View {
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
