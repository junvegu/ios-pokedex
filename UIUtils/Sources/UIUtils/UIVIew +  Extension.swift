//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/24.
//

import Foundation
import UIKit

public extension UIView {
    func fillSuperview() {
    guard let superview = superview else {
      return
    }
    translatesAutoresizingMaskIntoConstraints = false

    let constraints: [NSLayoutConstraint] = [
      leftAnchor.constraint(equalTo: superview.leftAnchor),
      rightAnchor.constraint(equalTo: superview.rightAnchor),
      topAnchor.constraint(equalTo: superview.topAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }

    func centerInSuperview() {
    guard let superview = superview else {
      return
    }
    translatesAutoresizingMaskIntoConstraints = false
    let constraints: [NSLayoutConstraint] = [
      centerXAnchor.constraint(equalTo: superview.centerXAnchor),
      centerYAnchor.constraint(equalTo: superview.centerYAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }

    func constraint(equalTo size: CGSize) {
    guard superview != nil else { return }
    translatesAutoresizingMaskIntoConstraints = false
    let constraints: [NSLayoutConstraint] = [
      widthAnchor.constraint(equalToConstant: size.width),
      heightAnchor.constraint(equalToConstant: size.height),
    ]
    NSLayoutConstraint.activate(constraints)
  }

  @discardableResult
func addConstraints(
    _ top: NSLayoutYAxisAnchor? = nil,
    left: NSLayoutXAxisAnchor? = nil,
    bottom: NSLayoutYAxisAnchor? = nil,
    right: NSLayoutXAxisAnchor? = nil,
    centerY: NSLayoutYAxisAnchor? = nil,
    centerX: NSLayoutXAxisAnchor? = nil,
    topConstant: CGFloat = 0,
    leftConstant: CGFloat = 0,
    bottomConstant: CGFloat = 0,
    rightConstant: CGFloat = 0,
    centerYConstant: CGFloat = 0,
    centerXConstant: CGFloat = 0,
    widthConstant: CGFloat = 0,
    heightConstant: CGFloat = 0) -> [NSLayoutConstraint]
  {
    if superview == nil {
      return []
    }
    translatesAutoresizingMaskIntoConstraints = false

    var constraints = [NSLayoutConstraint]()

    if let top = top {
      let constraint = topAnchor.constraint(equalTo: top, constant: topConstant)
      constraint.identifier = "top"
      constraints.append(constraint)
    }

    if let left = left {
      let constraint = leftAnchor.constraint(equalTo: left, constant: leftConstant)
      constraint.identifier = "left"
      constraints.append(constraint)
    }

    if let bottom = bottom {
      let constraint = bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)
      constraint.identifier = "bottom"
      constraints.append(constraint)
    }

    if let right = right {
      let constraint = rightAnchor.constraint(equalTo: right, constant: -rightConstant)
      constraint.identifier = "right"
      constraints.append(constraint)
    }

    if let centerY = centerY {
      let constraint = centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant)
      constraint.identifier = "centerY"
      constraints.append(constraint)
    }

    if let centerX = centerX {
      let constraint = centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant)
      constraint.identifier = "centerX"
      constraints.append(constraint)
    }

    if widthConstant > 0 {
      let constraint = widthAnchor.constraint(equalToConstant: widthConstant)
      constraint.identifier = "width"
      constraints.append(constraint)
    }

    if heightConstant > 0 {
      let constraint = heightAnchor.constraint(equalToConstant: heightConstant)
      constraint.identifier = "height"
      constraints.append(constraint)
    }

    NSLayoutConstraint.activate(constraints)
    return constraints
  }

   func addSubviews(_ subviews: UIView...) {
    subviews.forEach { addSubview($0) }
  }
}

public extension UIView {
    func addBottomShadow() {
        layer.masksToBounds = true
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset =  CGSize(width: 10 , height: 10)
        layer.shadowRadius = 4
        layer.cornerRadius = 16
    }
}


public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}


public extension UIView {
    func roundBottom() {
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 40)
    }
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                layer.mask = mask
    }
}
