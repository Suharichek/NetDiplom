//
//  PhotosArray.swift
//  Navigation
//
//  Created by Suharik on 15.11.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

private let photosArray = (1...10).compactMap {"\($0)"}
private let imageProcessor = ImageProcessor()
public var filtredPhotosArray:[UIImage] = []

public func createPhotosArray() {
    for i in photosArray {
        guard let pic = UIImage(named: i) else { return }
        filtredPhotosArray.append(pic)
    }
}
