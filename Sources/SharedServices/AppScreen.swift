//
//  AppScreen.swift
//  JKOShop
//
//  Created by Harry Ng on 18/2/2024.
//

import Foundation

public enum AppScreen: CaseIterable, Hashable, Identifiable {
    case product
    case cart
    case order
    
    public var id: AppScreen { self }
}
