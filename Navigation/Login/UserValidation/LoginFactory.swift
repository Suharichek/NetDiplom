//
//  LoginInspector.swift
//  Navigation
//
//  Created by Suharik on 02.06.2022.
//

import Foundation

class MyLoginFactory: LoginFactory {

    static let shared = MyLoginFactory()

    func returnLoginInspector() -> LoginViewControllerDelegate {
         let inspector = LoginInspector()
         return inspector
     }
}

