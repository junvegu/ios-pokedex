//
//  UILabel + AttributedString.swift
//  
//
//  Created by Junior on 7/10/23.
//
import UIKit

public extension UILabel {
    func highlightFont(searchedText: String?, font: UIFont) {
        guard let txtLabel = self.text, let searchedText = searchedText else {
            return
        }

        let attributeTxt = NSMutableAttributedString(string: txtLabel)
        let range: NSRange = attributeTxt.mutableString.range(of: searchedText, options: .caseInsensitive)
        let rangeAll: NSRange = attributeTxt.mutableString.range(of: txtLabel, options: .caseInsensitive)

        attributeTxt.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributeTxt.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: rangeAll)
        attributeTxt.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single, range: range)

        self.attributedText = attributeTxt
    }

}
public extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


