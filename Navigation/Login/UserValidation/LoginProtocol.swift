//
//  LoginProtocol.swift
//  Navigation
//
//  Created by Suharik on 25.09.2022.
//

import Foundation

protocol LoginFactory {
    func returnLoginInspector() -> LoginViewControllerDelegate
}
