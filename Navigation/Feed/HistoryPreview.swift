//
//  HistoryPreview.swift
//  Navigation
//
//  Created by Suharik on 30.11.2022.
//

import Foundation
import UIKit
import SnapKit
import iOSIntPackage

class HistoryPreview: UIView {
    let itemsPerRow: CGFloat = 5
    let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sectionInserts.left
        layout.sectionInset = sectionInserts
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier:HistoryCollectionViewCell.identifire)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .backgroundColor
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    func setupContent() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

extension HistoryPreview: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtredHistoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifire, for: indexPath) as? HistoryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(image: filtredHistoryArray[indexPath.item])
        return cell
    }
}

extension HistoryPreview: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow) - sectionInserts.left / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
