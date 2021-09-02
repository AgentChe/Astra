//
//  PartnerSignCollectionView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 01.09.2021.
//

import UIKit
import RxCocoa

final class PartnerSignCollectionView: AKPickerView {
    lazy var didSelect = PublishRelay<Sign>()
    
    lazy var elements = [
        PartnerSignCollectionElement(sign: Sign(code: .aries, name: "Sign.Aries".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .taurus, name: "Sign.Taurus".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .gemini, name: "Sign.Gemini".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .cancer, name: "Sign.Cancer".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .leo, name: "Sign.Leo".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .virgo, name: "Sign.Virgo".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .libra, name: "Sign.Libra".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .scorpio, name: "Sign.Scorpio".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .sagittarius, name: "Sign.Sagittarius".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .capricorn, name: "Sign.Capricorn".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .aquarius, name: "Sign.Aquarius".localized),
                                     isSelected: false),
        PartnerSignCollectionElement(sign: Sign(code: .pisces, name: "Sign.Pisces".localized),
                                     isSelected: false)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    public required init!(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PartnerSignCollectionCell.self), for: indexPath) as! PartnerSignCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let element = elements[indexPath.row]
        
        return CGSize(width: element.isSelected ? 261.scale : 161.scale,
                      height: element.isSelected ? 308.scale : 190.scale)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        39.5.scale
    }
    
    override func selectItem(_ item: Int, animated: Bool, notifySelection: Bool) {
        elements.forEach { $0.isSelected = false }
        elements[item].isSelected = true
        
        collectionView.reloadData()
        
        super.selectItem(item, animated: animated, notifySelection: notifySelection)
    }
}

// MARK: Public
extension PartnerSignCollectionView {
    func setup(code: Sign.Code) {
        guard let index = elements.firstIndex(where: { $0.sign.code == code }) else {
            return
        }
        
        selectItem(index, animated: false, notifySelection: true)
    }
}

// MARK: AKPickerViewDataSource
extension PartnerSignCollectionView: AKPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        elements.count
    }
}

// MARK: AKPickerViewDelegate
extension PartnerSignCollectionView: AKPickerViewDelegate {
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        let sign = elements[item].sign
        didSelect.accept(sign)
    }
}

// MARK: Private
private extension PartnerSignCollectionView {
    func initialize() {
        dataSource = self
        delegate = self
        
        maskDisabled = true
        
        collectionView.register(PartnerSignCollectionCell.self, forCellWithReuseIdentifier: String(describing: PartnerSignCollectionCell.self))
    }
}
