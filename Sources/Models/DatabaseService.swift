//
//  DatabaseService.swift
//  JKOShop
//
//  Created by Harry Ng on 19/2/2024.
//

import Foundation
import GRDB
import os.log

public class DatabaseService {
    public private(set) static var db: DatabasePool = setupDatabase()

    private init() {} // Private initialization to ensure singleton

    static func setupDatabase() -> DatabasePool {
        do {
            // Define the path for the database file
            let databaseURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("db.sqlite")
            
            var config = Configuration()
            config.foreignKeysEnabled = false
            
            #if DEBUG
            Logger.database.info("sqlite: \(databaseURL.path)")
            #endif
            
            // Create a DatabasePool
            let pool = try DatabasePool(path: databaseURL.path, configuration: config)
            return pool
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }
    
    public static func migrate() throws {
        try db.migrate()
    }
    
    public static func prepare() async throws {
        try await db.write { db in
            guard try Item.fetchCount(db) == 0 else { return }
            
            for item in Item.all() {
                try item.save(db)
            }
        }
    }
}

extension DatabaseWriter {
    func migrate() throws {
        var migrator: DatabaseMigrator {
            
            var migrator = DatabaseMigrator()
            
            migrator.registerMigration("20240219 - Item - Order") { db in
                try db.create(table: "item", options: .ifNotExists, body: { t in
                    t.primaryKey(["id"])
                    t.column("id", .text).notNull()
                    t.column("name", .text).notNull().defaults(to: "")
                    t.column("description", .integer).notNull().defaults(to: "")
                    t.column("price", .numeric).notNull().defaults(to: 0)
                    t.column("imageUrl", .text).notNull().defaults(to: "")
                    t.column("createdAt", .datetime).notNull().defaults(to: Date())
                })
                
                try db.create(table: "order", options: .ifNotExists, body: { t in
                    t.primaryKey(["id"])
                    t.column("id", .text).notNull()
                    t.column("price", .numeric).notNull().defaults(to: 0)
                    t.column("createdAt", .datetime).notNull().defaults(to: Date())
                })
            }
            
            return migrator
        }
        
        try migrator.migrate(self)
    }
}

public extension Logger {
    
    static let loggingSubsystem: String = "demo.JKOShop"
    
    static let ui = Logger(subsystem: loggingSubsystem, category: "UI")
    static let database = Logger(subsystem: loggingSubsystem, category: "Database")
}
