//
//  Image+Extensions.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import SwiftUI

public extension Image {
    static func getSafeImage(named: String) -> Image {
        if let uiImage = UIImage(named: named) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "tent.2")
        }
    }
}
