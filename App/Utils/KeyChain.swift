//
//  KeyChain.swift
////
//  Created by Chuong Vu Duy on 12/22/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

public class KeyChain: NSObject {

    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }

    class func delete(key: String) {

        let query : [String: AnyObject] = [
            kSecClass as String             : kSecClassGenericPassword,
            kSecAttrAccount as String : key as AnyObject
        ]
        let status = SecItemDelete(query as CFDictionary)

        switch status {
        case errSecItemNotFound:
            print("No key in keychain")
        case noErr:
            print("All Keys Deleted!")
        default:
            print("SecItemDelete error! \(status.description)")
        }
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
