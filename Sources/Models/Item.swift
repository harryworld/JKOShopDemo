//
//  Item.swift
//  JKOShop
//
//  Created by Harry Ng on 12/2/2024.
//

import Foundation
import SwiftDate

public struct Item: Hashable, Identifiable {
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
            createdAt: Date() - 1.days
        )
        
        Item(
            id: "tcr",
            name: "TCR Advanced SL Disc 1 KOM",
            description: "經典傳騎，再立新猷！TCR ADVANCED SL DISC 在23年來不斷的研發創新，並持續地站在自行車公路競賽的尖端，如今以更輕、更強的剛性及大幅進化的空力表現再次出擊，加上整合式碟煞系統全天候一致的制動力，在競賽過程中追求極致的騎乘表現，TCR ADVANCED SL DISC 是你的唯一選擇。",
            price: 228000,
            imageUrl: "giant/tcr",
            createdAt: Date() - 2.days
        )
        
        Item(
            id: "contend",
            name: "CONTEND SL DISC 1",
            description: "協助騎士提升自信與操控進而享受公路騎乘體驗， 透過頂尖鋁合金製造工藝推出的全能車型車款，將穩定、操控性與輕量化效率融為一體，帶來卓越的騎乘品質。",
            price: 39800,
            imageUrl: "giant/contend",
            createdAt: Date() - 3.days
        )
        
        Item(
            id: "defy",
            name: "DEFY ADVANCED SL 0",
            description: "DEFY的存在，就是要帶你看到更遠的風景，他能帶你爬得更高、騎得更快，更重要的是，每一次的騎程都充滿舒適與自在。 GIANT工程團隊經歷數年研發，將DEFY一直以來深受騎士們喜愛的特點全面升級，包含DEFY原本就難以匹敵的輕量效率與絕佳順應性。現在，全新第五代DEFY變得更輕、更舒適、更有效率，不論你是要來場一日系列的長程挑戰，還是你想要完成內心深處那最瘋狂的騎程目標，DEFY都會是你的最佳首選。",
            price: 308000,
            imageUrl: "giant/defy",
            createdAt: Date() - 4.days
        )
        
        Item(
            id: "revolt",
            name: "REVOLT ADVANCED PRO 1",
            description: "FAST GRAVEL IS FUN GRAVEL. THE RACE BIKE OF CHOICE FOR GIANT GRAVEL RACING PROS IS SUPERLIGHT, SMOOTH OVER RUGGED ROADS, AND ADAPTABLE TO ALL TYPES OF CONDITIONS AND RIDING STYLES. RACE IT, RIDE IT, LOVE IT.",
            price: 148000,
            imageUrl: "giant/revolt",
            createdAt: Date() - 2.days
        )
        
        Item(
            id: "fastroad",
            name: "FASTROAD AR ADVANCED 2",
            description: "沒想到騎車運動也能這麼好玩!時尚有型的碳纖車架，舒適好操控的平把騎姿，能讓騎士騎遍更種路況的細節設計，輕盈好操控的FASTROAD AR ADVANCED讓你從城市通勤一路玩至郊外碎石路。",
            price: 38000,
            imageUrl: "giant/fastroad",
            createdAt: Date() - 5.days
        )
        
        Item(
            id: "escape",
            name: "ESCAPE DISC 1",
            description: "在城市中全速前進，平把公路車是您的運動首選。 週間空閒還有周末假期時，就別賴在家裡了。 跨上自行車，不僅休閒騎，也兼具運動健身功能；專注於雙腳踩踏間，所有疲憊與煩惱都將煙消雲散，騎動健康就從現在開始做起吧",
            price: 18800,
            imageUrl: "giant/escape",
            createdAt: Date() - 1.months
        )
        
        Item(id: "airway", name: "AIRWAY SIDEPULL", description: "側開式碳纖維水壺架", price: 1100, imageUrl: "others/airway", createdAt: Date())
        
        Item(id: "bottle", name: "高流量水壺", description: "750 C.C.", price: 160, imageUrl: "others/bottle", createdAt: Date())
        
        Item(id: "bag", name: "SHADOW DX TRUNK BAG", description: "貨架上袋", price: 1700, imageUrl: "others/bag", createdAt: Date())
        
        Item(id: "seatbag", name: "SHADOW ST", description: "輕量版坐墊袋", price: 550, imageUrl: "others/seatbag", createdAt: Date())
        
        Item(id: "head", name: "REV PRO MIPS", description: "公路車安全帽", price: 6280, imageUrl: "body/head", createdAt: Date())
        
        Item(id: "clothes", name: "RACE DAY", description: "連身三鐵服", price: 3980, imageUrl: "body/clothes", createdAt: Date())
        
        Item(id: "gloves", name: "GIANT ELEVATE", description: "長指手套", price: 980, imageUrl: "body/gloves", createdAt: Date())
        
        Item(id: "glasses", name: "APUS NXT", description: "無框太陽眼鏡-全天候變色鏡片", price: 2980, imageUrl: "body/glasses", createdAt: Date())
        
        Item(id: "rain", name: "SUPERLIGHT", description: "超輕防風外套", price: 2680, imageUrl: "body/rain", createdAt: Date() - 2.days)
        
        Item(id: "shoes", name: "SURGE COMP MES", description: "尼龍車鞋", price: 3800, imageUrl: "body/shoes", createdAt: Date() - 2.days)
        
        Item(id: "socks", name: "ELEVATE SOCKS", description: "", price: 480, imageUrl: "body/socks", createdAt: Date() - 2.days)
        
        Item(id: "hat", name: "Hat", description: "多功能透氣帽", price: 580, imageUrl: "body/hat", createdAt: Date() - 3.days)
        
        Item(id: "training", name: "CYCLOTRON FLUID ST", description: "油阻式訓練台(鐵)", price: 8800, imageUrl: "others/training", createdAt: Date())
        
        Item(id: "mat", name: "SARIS", description: "訓練地墊", price: 2600, imageUrl: "others/mat", createdAt: Date() - 2.months)
    }
    
    static let mock = Item(for: "propel")!
    static let propel = Item(for: "propel")!
    static let tcr = Item(for: "tcr")!
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
