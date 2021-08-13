//
//  PaddingTextField.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import  UIKit

class PaddingTextField: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10.scale,
        left: 20.scale,
        bottom: 10.scale,
        right: 20.scale
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
