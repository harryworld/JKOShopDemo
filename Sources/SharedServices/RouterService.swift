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
    public var orderRoutes: [OrderRoute] = []
    
    public init(
        productRoutes: [ProductRoute] = [],
        orderRoutes: [OrderRoute] = []
    ) {
        self.productRoutes = productRoutes
        self.orderRoutes = orderRoutes
    }
}

public enum ProductRoute: Hashable {
    case productDetail(Item)
    case cart
    case cartConfirm
}

public enum OrderRoute: Hashable {
    case orderDetail(Order)
}
