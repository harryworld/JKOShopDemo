//
//  OrderInfo.swift
//  JKOShop
//
//  Created by Harry Ng on 19/2/2024.
//

import Foundation
import GRDB

public struct OrderInfo: Decodable, FetchableRecord, Hashable, Identifiable {
    public var id: String { order.id }
    
    public var order: Order
    public var items: [Item]
    
    public init(order: Order, items: [Item]) {
        self.order = order
        self.items = items
    }
    
    public static func all() -> QueryInterfaceRequest<OrderInfo> {
        return Order
            .including(all: Order.items)
            .order(Order.Columns.createdAt.desc)
            .asRequest(of: OrderInfo.self)
    }
}

public extension OrderInfo {
    var coverImageUrl: String {
        items.first!.imageUrl
    }
    var name: String {
        items.first!.name
    }
    var description: String {
        items.first!.description
    }
    
    static let mock = OrderInfo(order: .init(price: 600000), items: [.propel, .tcr])
}
