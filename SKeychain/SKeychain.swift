//
//  SKeychain.swift
//  SKeychain
//
//  Created by Vladimir Espinola on 6/24/18.
//  Copyright © 2018 Vladimir Espinola. All rights reserved.
//

import LocalAuthentication

open class SKeychain {
    
    public class func save(with key: String, data: String){
        guard let data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return }
        
        // Delete the old value.
        delete(with: key)
        
        let service = Bundle.main.bundleIdentifier!
        
        
        let accessControl: SecAccessControl!
        
        if #available(iOS 11.3, *) {
            accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, .biometryAny, nil)
        } else if #available(iOS 9.0, *) {
            accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, .touchIDAny, nil)
        } else {
            // Fallback on earlier versions
            accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, .userPresence, nil)
        }
        
        let keychainQuery: [NSString: AnyObject] = [
            kSecClass                   : kSecClassGenericPassword,
            kSecAttrService             : service as AnyObject,
            kSecAttrAccount             : (service + ".\(key)") as AnyObject,
            kSecValueData               : data as AnyObject,
            kSecAttrAccessControl       : accessControl!,
            ]
        
        
        SecItemAdd(keychainQuery as CFDictionary, nil)
        
    }
    
    public class func load(with key: String, prompt: String? = nil) -> String? {
        let service = Bundle.main.bundleIdentifier!
        
        var keychainQuery: [NSString: AnyObject] = [
            kSecClass              : kSecClassGenericPassword,
            kSecAttrService        : service as AnyObject,
            kSecAttrAccount        : (service + ".\(key )") as AnyObject,
            kSecReturnData         : true as AnyObject,
            kSecMatchLimit         : kSecMatchLimitOne
        ]
        
        if let prompt = prompt {
            keychainQuery[kSecUseOperationPrompt] = prompt as AnyObject?
        }
        
        var dataTypeRef: AnyObject?
        
        let status: OSStatus = withUnsafeMutablePointer(to: &dataTypeRef) {
            SecItemCopyMatching(keychainQuery as CFDictionary, UnsafeMutablePointer($0))
        }
        
        var contentsOfKeychain: String?
        if status == errSecSuccess {
            if let retrivedData = dataTypeRef as? NSData {
                contentsOfKeychain = String(data: retrivedData as Data, encoding: String.Encoding.utf8)
            }
        }
        
        return contentsOfKeychain
    }
    
    public class func delete(with key: String) {
        let service = Bundle.main.bundleIdentifier!
        
        let keychainQuery: [NSString: AnyObject] = [
            kSecClass       : kSecClassGenericPassword,
            kSecAttrService : service as AnyObject,
            kSecAttrAccount : (service + ".\(key)") as AnyObject,
        ]
        
        SecItemDelete(keychainQuery as CFDictionary)
    }
    
}
