//
//  Order.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import Foundation
import GRDB

public struct Order: Codable, Equatable, Hashable, Identifiable {
    public let id: String
    public var price: Double
    public var createdAt: Date

    public init(
        id: String = UUID().uuidString,
        price: Double,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.price = price
        self.createdAt = createdAt
    }
}

extension Order: TableRecord, FetchableRecord, PersistableRecord {
    enum Columns: String, ColumnExpression {
        case id
        case price
        case createdAt
    }
    
    static let lineItems = hasMany(OrderLineItem.self)
    static let items = hasMany(Item.self, through: lineItems, using: OrderLineItem.item)
    public var items: QueryInterfaceRequest<Item> {
        request(for: Order.items)
    }
}


extension Order {
    init?(for id: Order.ID) {
        guard let order = Order.all().first(where: { $0.id == id }) else { return nil }
        self = order
    }
}

public extension Order {
    @OrderArrayBuilder
    static func all() -> [Order] {
        Order(id: "1", price: 0, createdAt: Date())
        Order(id: "2", price: 0, createdAt: Date())
        Order(id: "3", price: 0, createdAt: Date())
    }
    
    static let mock = Order(for: "2")!
}

@resultBuilder
enum OrderArrayBuilder {
    static func buildEither(first component: [Order]) -> [Order] {
        return component
    }

    static func buildEither(second component: [Order]) -> [Order] {
        return component
    }

    static func buildOptional(_ component: [Order]?) -> [Order] {
        return component ?? []
    }

    static func buildExpression(_ expression: Order) -> [Order] {
        return [expression]
    }

    static func buildExpression(_ expression: ()) -> [Order] {
        return []
    }

    static func buildBlock(_ Orders: [Order]...) -> [Order] {
        return Orders.flatMap { $0 }
    }
}
