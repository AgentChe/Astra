//
//  MeditationsFilterCollectionView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import UIKit

final class MeditationsFilterCollectionView: UICollectionView {
    lazy var elements = [MeditationsFilterCollectionElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MeditationsFilterCollectionView {
    func setup(elements: [MeditationsFilterCollectionElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension MeditationsFilterCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: MeditationsFilterCollectionCell.self), for: indexPath) as! MeditationsFilterCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDataSource
extension MeditationsFilterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20.scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: MeditationsFilterCollectionCell.calculateWidth(code: elements[indexPath.row].code),
               height: 34.scale)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var indexPaths = [IndexPath]()
        
        if let index = elements.firstIndex(where: { $0.isSelected }) {
            indexPaths.append(IndexPath(row: index, section: 0))
            
            elements[index].isSelected = false
        }
        
        elements[indexPath.row].isSelected = true
        
        indexPaths.append(IndexPath(row: indexPath.row, section: 0))
        
        reloadItems(at: indexPaths)
    }
}

// MARK: Private
private extension MeditationsFilterCollectionView {
    func initialize() {
        dataSource = self
        delegate = self
        
        register(MeditationsFilterCollectionCell.self, forCellWithReuseIdentifier: String(describing: MeditationsFilterCollectionCell.self))
    }
}
