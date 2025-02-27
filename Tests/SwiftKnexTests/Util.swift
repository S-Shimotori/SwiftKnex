//
//  Util.swift
//  SwiftKnex
//
//  Created by Yuki Takei on 2017/01/15.
//
//

import Foundation
import SwiftKnex

struct User: Entity, Serializable {
    let id: Int
    let name: String
    let email: String
    let age: Int
    let country: String?
    
    init(id: Int, name: String, email: String, age: Int, country: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.age = age
        self.country = country
    }
    
    init(row: Row) throws {
        self.id = row["id"] as! Int
        self.name = row["name"] as! String
        self.email = row["email"] as! String
        self.age = row["age"] as! Int
        self.country = row["country"] as? String
    }
    
    func serialize() throws -> [String: Any] {
        return [
            "name": name,
            "email": email,
            "age": age,
            "country": country
        ]
    }
}

extension Date {
    init?(dateTimeString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let d = dateStringFormatter.date(from: dateTimeString) {
            self.init(timeInterval:0, since:d)
        }
        else {
            return nil
        }
    }
}

func basicKnexConfig() -> KnexConfig {
    return KnexConfig(
        host: "localhost",
        port: 3306,
        user: "root",
        database: "swift_knex_test",
        isShowSQLLog: true
    )
}

func testUserLastLoginSchema() -> Create {
    return Create(table: "test_user_last_logins", fields: [
        Schema.Field(name: "id", type: Schema.Types.Integer()).asPrimaryKey().asAutoIncrement(),
        Schema.Field(name: "user_id", type: Schema.Types.Integer()).asUnique(),
        Schema.Field(name: "last_logined_at", type: Schema.Types.DateTime()).asIndex()
    ])
}

func testUserLastLoginCollection() -> [[String: Any]] {
    return [
        [
            "user_id": 1,
            "last_logined_at": Date(dateTimeString: "2017-01-01 23:57:32")!
        ],
        [
            "user_id": 3,
            "last_logined_at": Date(dateTimeString: "2016-12-31 16:00:00")!
        ],
        [
            "user_id": 7,
            "last_logined_at": Date(dateTimeString: "2016-01-12 08:31:42")!
        ]
    ]
}

func testUserSchema() -> Create {
    return Create(table: "test_users", fields: [
        Schema.Field(name: "id", type: Schema.Types.Integer()).asPrimaryKey().asAutoIncrement(),
        Schema.Field(name: "email", type: Schema.Types.String()).asUnique(),
        Schema.Field(name: "name", type: Schema.Types.String()).asNotNullable(),
        Schema.Field(name: "age", type: Schema.Types.Integer()).asNotNullable(),
        Schema.Field(name: "Country", type: Schema.Types.String()),
    ])
}

func testUserCollection() -> [[String: Any]] {
    return [
        [
            "email": "jack@example.com",
            "name": "Jack",
            "age": "23",
            "country": "USA"
        ],
        [
            "email": "tonny@example.com",
            "name": "Tonny",
            "age": "54",
            "country": "USA"
        ],
        [
            "email": "jaccky@example.com",
            "name": "Jackky",
            "age": "30",
            "country": "China"
        ],
        [
            "email": "yuki@example.com",
            "name": "Yuki",
            "age": "18",
            "country": "Japan"
        ],
        [
            "email": "ray@example.com",
            "name": "Ray",
            "age": "43",
        ],
        [
            "email": "rechard@example.com",
            "name": "Rechard",
            "age": "81",
            "country": "USA"
        ],
        [
            "email": "julia@example.com",
            "name": "Julia",
            "age": "15",
        ]
    ]
}
