//
//  BederrProgressView.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 8/12/23.
//

import UIKit

public class BDRProgressView : UIProgressView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()

    }
    
    func setupView(){
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        self.clipsToBounds = true
        self.progressTintColor = .primary
        self.trackTintColor = .lightGray.withAlphaComponent(0.3)
    }
    
}
