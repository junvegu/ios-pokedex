//
//  BDRRulesPasswordView.swift
//  
//
//  Created by Junior on 7/10/23.
//

import Foundation
import UIKit

public class BDRRulesPasswordView: UIView {

    struct Rule {
        let name: String
        static let rules: [Rule] = [Rule(name: "*Al menos 8 caracteres"),
                                    Rule(name: "*Al menos un número."),
                                    Rule(name: "*Al menos una letra minúscula"),
                                    Rule(name: "*Al menos carácter especial"),
                                    Rule(name: "*Al menos una letra mayúscula.")]
        
        static func createLabel(rule: Rule) -> UILabel{
            let label = UILabel()
            label.text = rule.name
            label.font = UIFont.bederrRegular(12)
            return label
        }
    }

    private lazy var stackForm: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = .zero
        return view
    }()

    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.font = .bederrRegular(12)
        label.text = "Tu contraseña debe contener:"
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        addSubview(stackForm)
        NSLayoutConstraint.activate([
            stackForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingLayoutSmall),
            stackForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacingLayout1xSmall),
            stackForm.topAnchor.constraint(equalTo: topAnchor),
            stackForm.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        stackForm.addArrangedSubview(labelDescription)
        for rule in Rule.rules {
            stackForm.addArrangedSubview(Rule.createLabel(rule: rule))
        }
    }
    
  
}
