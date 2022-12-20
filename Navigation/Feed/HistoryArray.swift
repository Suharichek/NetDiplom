//
//  HistoryArray.swift
//  Navigation
//
//  Created by Suharik on 07.12.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

private let historyArray = (11...20).compactMap {"\($0)"}
private let imageProcessor = ImageProcessor()
public var filtredHistoryArray:[UIImage] = []

public func createHistoryArray() {
    for i in historyArray {
        guard let pic = UIImage(named: i) else { return }
        filtredHistoryArray.append(pic)
    }
}

