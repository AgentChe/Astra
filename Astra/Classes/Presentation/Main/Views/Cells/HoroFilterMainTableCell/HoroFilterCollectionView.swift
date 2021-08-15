//
//  HoroFilterCollectionView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 15.08.2021.
//

import UIKit

final class HoroFilterCollectionView: UICollectionView {
    weak var horoFilterDelegate: HoroFilterCellDelegate?
    
    private lazy var filters = [HoroFilterTableElement]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension HoroFilterCollectionView {
    func setup(filters: [HoroFilterTableElement]) {
        self.filters = filters
        
        reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension HoroFilterCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: HoroFilterCollectionCell.self), for: indexPath) as! HoroFilterCollectionCell
        cell.setup(filter: filters[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDataSource
extension HoroFilterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let attrs = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 19.scale))
            .lineHeight(22.8.scale)
        
        let width = filters[indexPath.row].title.attributed(with: attrs).size().width
        let totalWidth = width + 34.scale
        
        return CGSize(width: totalWidth, height: 34.scale)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldSelectedIndex = filters.firstIndex(where: { $0.isSelected })
        
        if let row = oldSelectedIndex, row == indexPath.row {
            return
        }
        
        var updated = [indexPath]

        if let row = oldSelectedIndex {
            filters[row].isSelected = false
            updated.append(IndexPath(row: row, section: 0))
        }
        
        filters[indexPath.row].isSelected = true
        
        reloadItems(at: updated)
        
        horoFilterDelegate?.horoFilterCellDidUpdated(selectedPeriod: filters[indexPath.row].title)
    }
}

// MARK: Private
private extension HoroFilterCollectionView {
    func initialize() {
        register(HoroFilterCollectionCell.self, forCellWithReuseIdentifier: String(describing: HoroFilterCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
