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
    public static let shared = DatabaseService()
    
    var db: DatabasePool!

    private init() {} // Private initialization to ensure singleton

    func setupDatabase() {
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
            db = try DatabasePool(path: databaseURL.path, configuration: config)
            
            // Perform database setup or migrations here
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }
    
    public func migrate() throws {
        setupDatabase()
        try db.migrate()
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
