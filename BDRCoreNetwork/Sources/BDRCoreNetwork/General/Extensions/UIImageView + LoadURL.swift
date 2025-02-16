//
//  UIImageView + LoadURL.swift
//  
//
//  Created by Junior on 21/11/22.
//


import UIKit

public extension UIImageView {
    func downloaded(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        self.af.setImage(withURL: url)
    }
    
    func downloaded(link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let safePath = link, let safeURL = URL.init(string: safePath) else { return }
        downloaded(url: safeURL, contentMode: mode)
    }
}
