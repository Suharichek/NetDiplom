//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Suharik on 12.10.2022.
//

import Foundation
import SnapKit
import LocalAuthentication

class LocalAuthorizationService {
    
    static var shared = LocalAuthorizationService()
    var context = LAContext()
    let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    var canUseBiometrics = false
    var error: NSError? = nil
    
    init() {
        canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
    }
    
    public func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        guard canUseBiometrics else {
            return
        }
        context.evaluatePolicy(policy, localizedReason: "Auth for enter")
        { [weak self] success,error in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                if success {
                    authorizationFinished(self.canUseBiometrics, error)
                }
            }
        }
    }
}

