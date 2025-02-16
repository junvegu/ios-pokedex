//
//  BDRCheckBox.swift
//  
//
//  Created by Junior on 22/10/22.
//

import Foundation
import UIKit

public class BDRCheckBox: UIButton {
    // Images
    let checkedImage = UIImage.loadFromAssets("checked")
    let uncheckedImage = UIImage.loadFromAssets("unchecked")

    // Bool property
    public var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }

    public override func awakeFromNib() {
        self.addTarget(self,action: #selector(buttonClicked), for:
                        UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
