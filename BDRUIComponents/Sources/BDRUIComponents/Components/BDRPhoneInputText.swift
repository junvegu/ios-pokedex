//
//  BDRPhoneInputText.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 8/12/23.
//

import Foundation
import UIKit
import PhoneNumberKit
public class MyGBTextField: PhoneNumberTextField {
    public override var defaultRegion: String {
        get {
            return "GB"
        }
        set {} // exists for backward compatibility
    }
}
open class BDRPhoneInputText: BDRCustomControl {
    @IBOutlet public weak var contentTextField: BDRMaterialTextField!
    @IBOutlet public weak var phoneTextField: PhoneNumberTextField! {
        didSet {
            phoneTextField.withPrefix = true
            phoneTextField.withExamplePlaceholder = true
            phoneTextField.font = UIFont.bederrBold(16)
            phoneTextField.withDefaultPickerUI = true
            phoneTextField.withDefaultPickerUIOptions = .init(textLabelFont: .bederrBold(14), detailTextLabelFont: .bederrRegular(14))
        }
    }
    
    public var phoneCode: String {
        (phoneTextField.phoneNumber?.countryCode.description ?? "")
    }

    public var placeHolder: String = ""{
        didSet {
            contentTextField.placeholder = placeHolder
        }
    }

    public var phoneNumber: String? {
        phoneTextField.phoneNumber?.nationalNumber.description.replacingOccurrences(of: " ", with: "")
    }
    
    public var fullPhoneNumber: String {
        (phoneTextField.phoneNumber?.countryCode.description ?? "" ) +  (phoneTextField.phoneNumber?.nationalNumber.description.replacingOccurrences(of: " ", with: "") ?? "")
    }

    public var isValidPhone: Bool {
        phoneTextField.isValidNumber
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
        contentTextField.text = " "
        phoneTextField.borderStyle = .none
        phoneTextField.withFlag = true
        contentTextField.isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    
    public func setupPhoneConfig(flag: Bool = true, regionDefault: String = "PE" ) {
        phoneTextField.withFlag = flag
        
        
      //  phoneTextField.defaultRegion = "AR"
      //  phoneTextField.currentRegion = "AR"
    }
}
import BDRModel
public struct PhoneNumberValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let candidate = val, !candidate.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
        let result = PhoneNumberKit().isValidPhoneNumber("+"+candidate)
        if !result {
            throw ValidationError.custom(message: "EL número no tiene formato válido")
        }
    }
}
