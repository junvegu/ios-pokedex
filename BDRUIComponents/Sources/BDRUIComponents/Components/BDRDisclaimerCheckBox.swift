//
//  File.swift
//  
//
//  Created by Junior on 7/10/23.
//
import Foundation
import UIKit
import Combine
public class BDRDisclaimerCheckBox: UIView {
    
    public var tapTextAction: (() -> ())?
    public var onChangeValue: ((Bool) -> (Void))?
    private var subscribers = Set<AnyCancellable>()
    
    private lazy var checkBox: BDRCheckBox = {
        let checkbox = BDRCheckBox()
        checkbox.isChecked = false
        checkbox.isUserInteractionEnabled = true
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.font = .bederrRegular(14)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var isChecked: Bool {
        get {
            return checkBox.isChecked
        }
        set {
            checkBox.isChecked = newValue
        }
    }
    
    public func setDescription(text: String, highLightText: String = "") {
        labelDescription.text = text
        labelDescription.highlightFont(searchedText: highLightText, font: .bederrBold(14))
    }
    
    // MARK: - Lifecycle
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    private func setupView() {
        isUserInteractionEnabled = true
        addSubview(checkBox)
        addSubview(labelDescription)
        NSLayoutConstraint.activate([
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingLayoutSmall),
            checkBox.trailingAnchor.constraint(equalTo: labelDescription.leadingAnchor, constant: -.spacingLayout1xSmall),
            checkBox.centerYAnchor.constraint(equalTo: labelDescription.centerYAnchor),
            labelDescription.topAnchor.constraint(equalTo: topAnchor),
            labelDescription.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacingLayout1xSmall)
            
        ])
        setupLabelTap()
        
        checkBox.eventPublisher(for: .touchUpInside).sink(receiveValue: { [weak self] button in
            guard let self = self else { return }
            self.isChecked = !self.isChecked
            self.onChangeValue?(self.isChecked)
        }).store(in: &subscribers)
        
        
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        print("labelTapped")
        tapTextAction?()
    }
    
    private func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        labelDescription.isUserInteractionEnabled = true
        labelDescription.addGestureRecognizer(labelTap)
        
    }
}
