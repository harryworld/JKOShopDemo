//
//  iOSCheckboxToggleStyle.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import SwiftUI

/// Simulate checkbox on Mac
/// Reference: https://sarunw.com/posts/swiftui-checkbox/
public struct iOSCheckboxToggleStyle: ToggleStyle {
    
    // ============
    // MARK: - Init
    // ============
    
    public init() {}
    
    // ============
    // MARK: - Body
    // ============
    
    public func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                
                configuration.label
            }
        })
        .buttonStyle(.plain)
    }
}
