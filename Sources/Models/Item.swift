//
//  Item.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import Foundation

public struct Item: Identifiable {
    public let id: String
    public var name: String
    public var description: String
    public var price: Double
    public var imageUrl: String
    public var createdAt: Date

    public init(
        id: String = UUID().uuidString,
        name: String,
        description: String,
        price: Double,
        imageUrl: String,
        createdAt: Date
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.imageUrl = imageUrl
        self.createdAt = createdAt
    }
}

extension Item {
    init?(for id: Item.ID) {
        guard let item = Item.all().first(where: { $0.id == id }) else { return nil }
        self = item
    }
}

public extension Item {
    @ItemArrayBuilder
    static func all() -> [Item] {
        Item(
            id: "propel",
            name: "PROPEL Advanced SL 0",
            description: "為勝利而生，就是全新PROPEL ADVANCED SL 的最佳註解，更輕、更空力、更好的調整系統，全新PROPEL與你一起贏得更多勝利。",
            price: 328000,
            imageUrl: "giant/propel",
            createdAt: Date()
        )
        
        Item(
            id: "tcr",
            name: "TCR Advanced SL Disc 1 KOM",
            description: "經典傳騎，再立新猷！TCR ADVANCED SL DISC 在23年來不斷的研發創新，並持續地站在自行車公路競賽的尖端，如今以更輕、更強的剛性及大幅進化的空力表現再次出擊，加上整合式碟煞系統全天候一致的制動力，在競賽過程中追求極致的騎乘表現，TCR ADVANCED SL DISC 是你的唯一選擇。",
            price: 228000,
            imageUrl: "giant/tcr",
            createdAt: Date()
        )
    }
}

@resultBuilder
enum ItemArrayBuilder {
    static func buildEither(first component: [Item]) -> [Item] {
        return component
    }

    static func buildEither(second component: [Item]) -> [Item] {
        return component
    }

    static func buildOptional(_ component: [Item]?) -> [Item] {
        return component ?? []
    }

    static func buildExpression(_ expression: Item) -> [Item] {
        return [expression]
    }

    static func buildExpression(_ expression: ()) -> [Item] {
        return []
    }

    static func buildBlock(_ Items: [Item]...) -> [Item] {
        return Items.flatMap { $0 }
    }
}
