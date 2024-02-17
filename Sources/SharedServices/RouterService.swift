//
//  RouterService.swift
//  JKOShop
//
//  Created by Harry Ng on 17/2/2024.
//

import Foundation
import Models
import Observation

@Observable
public final class RouterService {
    public var productRoutes: [ProductRoute] = []
    
    public init(
        productRoutes: [ProductRoute] = []
    ) {
        self.productRoutes = productRoutes
    }
}

public enum ProductRoute: Hashable {
    case productDetail(Item)
    case cart
    case cartConfirm
}
