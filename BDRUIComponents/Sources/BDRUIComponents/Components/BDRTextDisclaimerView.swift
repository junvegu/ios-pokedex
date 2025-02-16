//
//  File.swift
//  
//
//  Created by Junior on 14/09/22.
//

import Foundation
import UIKit

@IBDesignable public class BDRTextDisclaimerView: BDRCustomControl {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var backgroundStyle: UIView!
    @IBInspectable
    public var title: String = "" {
        didSet {
            titleLabel.text = title.uppercased()
        }
    }
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.loadViewFromNib()
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.loadViewFromNib()
        self.commonInit()
    }
    
    private func commonInit() {
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        backgroundStyle.backgroundColor = .disclaimerColor
        titleLabel.font = .bederrRegular(13)
        titleLabel.textColor = .textDisclaimerColor
    }

}
