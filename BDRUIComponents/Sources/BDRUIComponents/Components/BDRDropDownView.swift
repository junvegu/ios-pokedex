//
//  File.swift
//  
//
//  Created by Junior on 17/09/22.
//

import Foundation
import UIKit

open class BDRDropDownView: BDRCustomControl {
    
    @IBOutlet open weak var dropDownTextField: DropDownTextField!
    @IBOutlet open weak var backgroundStyle: UIView!
    @IBOutlet open weak var cardView: UIView!
    @IBOutlet open weak var textField: BDRMaterialTextField!
    open var setFirstElementLikeDefault = false
    open var placeholder: String = "" {
        didSet {
            if dropDownTextField.selectedValue == nil {
                textField.placeholder = placeholder
            } else {
                dropDownTextField.placeholder = ""
            }
        }
    }

    open var elements: [NSObject] = [] {
        didSet {
            dropDownTextField.elements = elements
            if (setFirstElementLikeDefault || elements.count == 1), let first = elements.first {
                selectedValue = first
            }
        }
    }
    
    open var text: String = "" {
        didSet {
            textField.text = text
        }
    }
    
    open var selectedValue: NSObject? {
        set {
            dropDownTextField.selectedValue = newValue
        }
        get {
            dropDownTextField.selectedValue
        }
    }
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.loadViewFromNib()
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.loadViewFromNib()
        self.commonInit()
    }
    
    private func commonInit() {
        textField.text = " "
        textField.isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    open func disable() {
        textField.isEnabled = false
        isUserInteractionEnabled = false
        dropDownTextField.textColor = .lightGray
    }
}

open class Gender: NSObject {
    public let name : String
    public let key: String

    internal init(name: String, key: String) {
        self.name = name
        self.key = key
    }

    public override var description: String {
        return name
    }
}

public extension BDRDropDownView {
    func applyGenderPick() {
        dropDownTextField.elements = [Gender(name: "Masculino", key: "M"), Gender(name: "Femenino", key: "M") ]
        dropDownTextField.placeholder = "Seleccione un género"
    }
    
    func selectGenderMale() {
        if !dropDownTextField.elements.isEmpty  {
            dropDownTextField.selectedValue = dropDownTextField.elements.first as? Gender
        }
    }
    
    func selectGenderFemale() {
        if !dropDownTextField.elements.isEmpty  {
            dropDownTextField.selectedValue = dropDownTextField.elements.last as? Gender
        }
    }
}
