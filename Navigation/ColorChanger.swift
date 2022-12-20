//
//  ColorChanger.swift
//  Navigation
//
//  Created by Suharik on 07.10.2022.
//

import Foundation
import UIKit

public extension UIColor {
    static var backgroundColor: UIColor {
        Self.createColor(lightMode: .init(red: 1, green: 0.686, blue: 0.690, alpha: 1), darkMode: .init(red: 0, green: 0, blue: 0.176, alpha: 1))
    }
    static var textColor: UIColor {
        Self.createColor(lightMode: .init(red: 0.400, green: 0.318, blue: 0.690, alpha: 1), darkMode: .init(red: 0.600, green: 0.918, blue: 0.835, alpha: 1))
    }
    static var labelBackColor: UIColor {
        Self.createColor(lightMode: .init(red: 0.878, green: 0.745, blue: 0.835, alpha: 1), darkMode: .init(red: 0, green: 0, blue: 0.455, alpha: 1))
    }
    static var buttonColor: UIColor {
        Self.createColor(lightMode: .init(red: 0.878, green: 0.745, blue: 0.835, alpha: 1), darkMode: .init(red: 0, green: 0, blue: 0.455, alpha: 1))
    }
    static var imageBackColor: UIColor {
        Self.createColor(lightMode: .init(red: 1, green: 0.536, blue: 0.690, alpha: 1), darkMode: .init(red: 0, green: 0, blue: 0.462, alpha: 1))
    }
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS  13.0, *) else {
            return lightMode
        }
        return UIColor {(traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
