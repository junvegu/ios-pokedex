//
//  BDRCardView.swift
//  
//
//  Created by Junior on 24/07/22.
//

import UIKit
public class BDRCardView : UIView {
    
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    func setupView(){
        cornerRadius = 16
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

    }
    
}
