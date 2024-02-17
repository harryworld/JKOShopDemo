//
//  Order.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import Foundation

public struct Order: Hashable, Identifiable {
    public let id: String
    public var items: [Item]
    public var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    public var createdAt: Date

    public init(
        id: String = UUID().uuidString,
        items: [Item],
        createdAt: Date
    ) {
        self.id = id
        self.items = items
        self.createdAt = createdAt
    }
}

extension Order {
    init?(for id: Order.ID) {
        guard let order = Order.all().first(where: { $0.id == id }) else { return nil }
        self = order
    }
}

public extension Order {
    var coverImageUrl: String {
        items.first!.imageUrl
    }
    var name: String {
        items.first!.name
    }
    var description: String {
        items.first!.description
    }
}

public extension Order {
    @OrderArrayBuilder
    static func all() -> [Order] {
        Order(id: "1", items: [.mock], createdAt: Date())
        
        Order(id: "2", items: [.propel, .tcr], createdAt: Date())
        
        Order(id: "3", items: [.tcr], createdAt: Date())
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
