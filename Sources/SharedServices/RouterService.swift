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
    public var selection: AppScreen = .product
    
    public var productRoutes: [ProductRoute] = []
    public var cartRoutes: [ProductRoute] = []
    public var orderRoutes: [OrderRoute] = []
    
    public init(
        selection: AppScreen = .product,
        productRoutes: [ProductRoute] = [],
        cartRoutes: [ProductRoute] = [],
        orderRoutes: [OrderRoute] = []
    ) {
        self.selection = selection
        self.productRoutes = productRoutes
        self.cartRoutes = cartRoutes
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
