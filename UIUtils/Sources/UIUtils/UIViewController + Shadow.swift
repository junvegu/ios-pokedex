//
//  UIViewController + Shadow.swift
//  
//
//  Created by Junior on 4/03/23.
//

import UIKit

public extension UIViewController {
    func setupShadowOnNavigation() {
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 2.0
        navigationController?.navigationBar.layer.shadowOpacity = 1.0
        navigationController?.navigationBar.layer.masksToBounds = false
    }
}


