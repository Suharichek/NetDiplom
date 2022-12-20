//
//  Authorization.swift
//  Navigation
//
//  Created by Suharik on 23.09.2022.
//

import Foundation
import RealmSwift

class AuthModel: Object {
    
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
}
