//
//  SignsPickerView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit
import RxCocoa

final class SignsPickerView: AKPickerView {
    lazy var didSelect = PublishRelay<Sign.Code>()
    
    lazy var elements = [
        SignsPickerElement(sign: Sign(code: .aries,
                                      name: "Sign.Aries".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .taurus,
                                      name: "Sign.Taurus".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .gemini,
                                      name: "Sign.Gemini".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .cancer,
                                      name: "Sign.Cancer".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .leo,
                                      name: "Sign.Leo".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .virgo,
                                      name: "Sign.Virgo".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .libra,
                                      name: "Sign.Libra".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .scorpio,
                                      name: "Sign.Scorpio".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .sagittarius,
                                      name: "Sign.Sagittarius".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .capricorn,
                                      name: "Sign.Capricorn".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .aquarius,
                                      name: "Sign.Aquarius".localized),
                           isSelected: false),
        SignsPickerElement(sign: Sign(code: .pisces,
                                      name: "Sign.Pisces".localized),
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SignsPickerCell.self), for: indexPath) as! SignsPickerCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let element = elements[indexPath.row]
        
        return CGSize(width: max(SignsPickerCell.calculateWidth(element: element), 60.scale),
                      height: element.isSelected ? 82.scale : 76.scale)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16.scale
    }
    
    override func selectItem(_ item: Int, animated: Bool, notifySelection: Bool) {
        elements.forEach { $0.isSelected = false }
        elements[item].isSelected = true
        
        collectionView.reloadData()
        
        super.selectItem(item, animated: animated, notifySelection: notifySelection)
    }
}

// MARK: Public
extension SignsPickerView {
    func select(sign: Sign.Code) {
        guard let index = elements.firstIndex(where: { $0.sign.code == sign }) else {
            return
        }
        
        selectItem(index, animated: false)
    }
}

// MARK: AKPickerViewDataSource
extension SignsPickerView: AKPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        elements.count
    }
}

// MARK: AKPickerViewDelegate
extension SignsPickerView: AKPickerViewDelegate {
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        let code = elements[item].sign.code
        didSelect.accept(code)
    }
}

// MARK: Private
private extension SignsPickerView {
    func initialize() {
        dataSource = self
        delegate = self
        
        maskDisabled = true
        
        collectionView.register(SignsPickerCell.self, forCellWithReuseIdentifier: String(describing: SignsPickerCell.self))
    }
}
