//
//  OrderLineItem.swift
//  JKOShop
//
//  Created by Harry Ng on 19/2/2024.
//

import Foundation
import GRDB

public struct OrderLineItem: Codable, Equatable, Hashable, Identifiable {
    public let id: String
    public let itemId: String
    public let orderId: String
    
    public init(
        id: String = UUID().uuidString,
        itemId: String,
        orderId: String
    ) {
        self.id = id
        self.itemId = itemId
        self.orderId = orderId
    }
}
extension OrderLineItem: TableRecord, FetchableRecord, PersistableRecord {
    enum Columns: String, ColumnExpression {
        case id
        case itemId
        case orderId
    }
    
    static let item = belongsTo(Item.self)
    static let order = belongsTo(Order.self)
}
