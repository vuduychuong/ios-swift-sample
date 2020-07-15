//
//  SecureHelper.swift
//

import UIKit

let PUBLIC_TAG = "com.chuongvd.tagPublic"

class SecureHelper: NSObject {
    
    class func getKeyTypeInKeyChain(tag : String) -> SecKey? {
        let query: [String: AnyObject] = [
            String(kSecClass)             : kSecClassKey,
            String(kSecAttrKeyType)       : kSecAttrKeyTypeRSA,
            String(kSecAttrApplicationTag): tag as AnyObject,
            String(kSecReturnRef)         : true as AnyObject
        ]
        
        var result : AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            return result as! SecKey?
        }
        
        return nil
    }
    
    class func addDerKeyInfo(rawPublicKey:[UInt8]) -> [UInt8] {
        let DerHdrSubjPubKeyInfo:[UInt8]=[
            /* Ref: RFC 5480 - SubjectPublicKeyInfo's ASN encoded header */
            0x30, 0x59, /* SEQUENCE */
            0x30, 0x13, /* SEQUENCE */
            0x06, 0x07, 0x2A, 0x86, 0x48, 0xCE, 0x3D, 0x02, 0x01, /* oid: 1.2.840.10045.2.1   */
            0x06, 0x08, 0x2A, 0x86, 0x48, 0xCE, 0x3D, 0x03, 0x01, 0x07, /* oid: 1.2.840.10045.3.1.7 */
            0x03, 0x42, /* BITSTRING */
            0x00 /* unused number of bits in bitstring, followed by raw public-key bits */]
        let derKeyInfo = DerHdrSubjPubKeyInfo + rawPublicKey
        return derKeyInfo
    }
    
    
    class func StoreInKeychain(tag: String, key: SecKey) {
        
        let attribute = [
            String(kSecClass)              : kSecClassKey,
            String(kSecAttrKeyType)        : kSecAttrKeyTypeRSA,
            String(kSecValueRef)           : key,
            String(kSecReturnPersistentRef): true
            ] as [String : Any]
        
        let status = SecItemAdd(attribute as CFDictionary, nil)
        
        if status != noErr {
            print("SecItemAdd Error!")
            return
        }
    }
    
    class func keyTypeStr(tag: String) -> String {
        
        return tag.replacingOccurrences(of: "com.coinplug.tag", with: "")
    }
    
    //Delete keys when required.
    class func deleteAllKeysInKeyChain() {
        
        let query : [String: AnyObject] = [
            String(kSecClass)             : kSecClassKey
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
    
    
    class func convertbase64StringToByteArray(base64String: String) throws -> [UInt8] {
        if let nsdata = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)  {
            var bytes = [UInt8](repeating: 0, count: nsdata.length)
            nsdata.getBytes(&bytes,length: nsdata.length)
            return bytes
        }
        else
        {
            print("Invalid base64 String")
        }
        
        let tempbytes = [UInt8](repeating: 0, count: 0)
        
        return tempbytes
    }
    
    
    class func convertSecKeyToDerKeyFormat(publicKey:SecKey) throws -> String
    {
        var error: Unmanaged<CFError>?
        do
        {
            if let externalRepresentationOfPublicKey = SecKeyCopyExternalRepresentation(publicKey,&error)
            {
                let derKeyFormat = externalRepresentationOfPublicKey as Data
                var publicKeyByteArray = try convertbase64StringToByteArray(base64String: derKeyFormat.base64EncodedString())
                publicKeyByteArray =  addDerKeyInfo(rawPublicKey: publicKeyByteArray)
                let base64EncodedPublicKey:String=Data(publicKeyByteArray).base64EncodedString()
                return base64EncodedPublicKey
            }
            else
            {
                throw error as! Error
            }
        }
        catch
        {
            throw error
        }
    }
    
    
    class func encryptStr(str: String) -> String {
        var encryptStr = ""
        
        if !str.isEmpty {
            encryptStr = SecureHelper.encryptBase64(text: str)
        }
        
        return encryptStr
    }
    
    
    class func decryptStr(str: String) -> String? {
        var decryptStr: String? = ""
        
        if !str.isEmpty {
            decryptStr = SecureHelper.decpryptBase64(encrpted: str)
        }
        
        return decryptStr
    }
    
    
    class func encryptBase64(text: String) -> String {
        let publicKey = SecureHelper.getKeyTypeInKeyChain(tag: PUBLIC_TAG)
        let plainBuffer = [UInt8](text.utf8)
        var cipherBufferSize : Int = Int(SecKeyGetBlockSize(publicKey!))
        var cipherBuffer = [UInt8](repeating:0, count:Int(cipherBufferSize))
        
        // Encrypto  should less than key length
        let status = SecKeyEncrypt(publicKey!, SecPadding.PKCS1, plainBuffer, plainBuffer.count, &cipherBuffer, &cipherBufferSize)
        if (status != errSecSuccess) {
            print("Failed Encryption")
        }
        
        let mudata = NSData(bytes: &cipherBuffer, length: cipherBufferSize)
        return mudata.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
    
    class func decpryptBase64(encrpted: String) -> String? {
        if encrpted.count == 0 {
            return String()
        }
        
        let privateKey = SecureHelper.getKeyTypeInKeyChain(tag: PUBLIC_TAG)
        let data : NSData = NSData(base64Encoded: encrpted, options: .ignoreUnknownCharacters)!
        let count = data.length / MemoryLayout<UInt8>.size
        var array = [UInt8](repeating: 0, count: count)
        data.getBytes(&array, length:count * MemoryLayout<UInt8>.size)
        
        var plaintextBufferSize = Int(SecKeyGetBlockSize(privateKey!))
        var plaintextBuffer = [UInt8](repeating:0, count:Int(plaintextBufferSize))
        
        let status = SecKeyDecrypt(privateKey!, SecPadding.PKCS1, array, plaintextBufferSize, &plaintextBuffer, &plaintextBufferSize)
        
        if (status != errSecSuccess) {
            print("Failed Decrypt")
            return ""
        }
        return NSString(bytes: &plaintextBuffer, length: plaintextBufferSize, encoding: String.Encoding.utf8.rawValue)! as String
    }
}
