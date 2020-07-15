//
//  LoginEntity.swift
//  Domain
//
//  Created by Chuong Vu Duy on 2/4/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

//{
//    "token": "007237dc7bec0a4be960650ddab5790e963f1050",
//    "user": {
//        "id": 136,
//        "username": "0x0000000000000000000000000000088f",
//        "first_name": "",
//        "last_name": "",
//        "email": "vuduychuong1994@gmail.com",
//        "gender": "male",
//        "is_active": true,
//        "is_staff": false,
//        "is_superuser": false,
//        "date_joined": "2020-01-20T12:58:58.393581+09:00",
//        "last_login": "2020-02-01T05:15:45.694198+09:00"
//    }
//}

import Foundation
public struct LoginEntity: Codable {
    public let token: String?
    public let user: User?
}

public struct User: Codable {
    public let id: Int?
    public let username, firstName, lastName, email: String?
    public let gender: String?
    public let isActive, isStaff, isSuperuser: Bool?
    public let dateJoined, lastLogin: String?

    enum CodingKeys: String, CodingKey {
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
        case email, gender
        case isActive = "is_active"
        case isStaff = "is_staff"
        case isSuperuser = "is_superuser"
        case dateJoined = "date_joined"
        case lastLogin = "last_login"
    }
}

// MARK: Convenience initializers

public extension LoginEntity {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(LoginEntity.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

public extension User {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(User.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

