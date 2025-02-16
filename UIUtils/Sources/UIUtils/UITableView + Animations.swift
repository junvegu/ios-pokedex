//
//  UITableView + Animations.swift
//  
//
//  Created by Junior on 3/03/23.
//

import UIKit

extension UITableView {
    public func refreshView(animationStyle: UITableView.RowAnimation = .fade) {
        self.reloadSections(.init(integer: 0), with: animationStyle)
    }
}
