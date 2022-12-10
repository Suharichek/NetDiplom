//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Suharik on 25.09.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func signing (signType: SignType, log: String, pass: String)
}
