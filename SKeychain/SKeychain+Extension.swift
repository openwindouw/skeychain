//
//  SKeychain+Extension.swift
//  SKeychain
//
//  Created by Vladimir Espinola on 6/24/18.
//  Copyright © 2018 Vladimir Espinola. All rights reserved.
//

import LocalAuthentication

public extension SKeychain {
    public static var hasAuthenticationWithBiometrics: Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    public static var useFaceID: Bool {
        if #available(iOS 11.0, *) {
            return evaluate(for: .faceID)
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    public static var useTouchID: Bool {
        if #available(iOS 11.0, *) {
            return evaluate(for: .touchID)
        } else {
            // Fallback on earlier versions
            return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        }
    }
    
    @available(iOS 11.0, *)
    private class func evaluate(for type: LABiometryType) -> Bool {
        let laContext = LAContext()
        guard laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) else { return false}
        return laContext.biometryType == type
    }
}
