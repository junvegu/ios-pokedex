//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 14/02/24.
//

import Foundation
import UIKit


@IBDesignable public class BDRSmallCardButtons: UIButton {
    
    // MARK: - Properties
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    public var currentBackground: UIColor?
    
    @IBInspectable public var borderWidth: CGFloat = 5 {
        didSet {
            self.layer.borderWidth = self.borderWidth
            self.setNeedsDisplay()
        }
    }
    @IBInspectable public var borderColor:UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = UIColor.systemBlue.cgColor
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupButton()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.currentBackground = UIColor.white
        self.backgroundColor = UIColor.white
        self.cornerRadius = 5
        self.setTitleColor(.systemBlue, for:  .normal)
    }
    
    // MARK: - Private
    fileprivate func setupButton() {
        
        self.titleLabel?.font = .bederrBold(15)
        self.titleLabel?.textColor = .systemBlue
        self.setTitleColor(.systemBlue, for:  .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
        self.backgroundColor = UIColor.white
        
    }
    
    public override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                
                backgroundColor = UIColor.lightGray
            }
            else {
                backgroundColor = UIColor.white
                
            }
            super.isHighlighted = newValue
        }
    }
    
}
