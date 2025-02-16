//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 9/08/24.
//

import Foundation
import UIKit
import UIUtils
public class BDRTagView: UIView {
    // MARK: - Public Types

    public enum Category: String, CaseIterable {
        case complete
        case reject
        case pending
        case disabled
    }



    // MARK: - Public Vars

    /// `category` defines the style for the Tag.
    public var category: Category {
        didSet { update() }
    }


    /// Text inside the Tag.
    public var text: String {
        didSet { update() }
    }

    /// Icon next to the text, at the left. If nil, no icon is added.
    public var icon: UIImageView? {
        didSet { update() }
    }

    /// Choose which corner to round.
    public var borderRadius: CGFloat = 4 {
        didSet { update() }
    }

    // MARK: - Private Vars

    private enum Constants {
        static let accessibilityId = "tag"
    }

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        //label.requireHuggingAndCompression()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        return stackView
    }()

    private var iconView: UIImageView?

    private var heightConstraint: NSLayoutConstraint!
    private var stackViewLeftConstraint: NSLayoutConstraint!
    private var stackViewRightConstraint: NSLayoutConstraint!

    // MARK: - Inits

    public convenience init() {
        self.init(text: "")
    }

    public init(
        category: Category = .disabled,
        text: String = "",
        icon: UIImageView? = nil,
        borderRadius: CGFloat = 4
    ) {
        self.category = category
        self.text = text
        self.icon = icon
        self.borderRadius = borderRadius
        super.init(frame: .zero)
        setup()
    }

    public required init?(coder: NSCoder) {
        self.category = .disabled
        self.text = ""
        self.icon = nil
        super.init(coder: coder)
        setup()
    }

    override public convenience init(frame: CGRect) {
        self.init()
    }

    // MARK: - Overrides

    override public func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Private

    // MARK: Setups

    private func setup() {
        setupLayout()
        setupAccessibility()
        update()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Content view
            contentView.heightAnchor.constraint(equalToConstant: 0)
                .storing(in: &heightConstraint),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),

            // Stack view
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
                .storing(in: &stackViewLeftConstraint),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
                .storing(in: &stackViewRightConstraint)
        ])

        stackView.addArrangedSubview(label)
    }

    private func setupAccessibility() {
        isAccessibilityElement = true
        accessibilityIdentifier = Constants.accessibilityId
        accessibilityTraits = .staticText
    }

    // MARK: Updates

    private func update() {
        updateIcon()
        updateStyle()
        updateAccessibility()
    }

    private func updateStyle() {
     
        contentView.layer.cornerRadius = borderRadius
        contentView.layer.borderWidth = 1
        switch category {
        case .complete:
            label.textColor = .enabledState
            contentView.layer.borderColor = UIColor.enabledState.cgColor
        case .reject:
            label.textColor = .rejectState
            contentView.layer.borderColor = UIColor.rejectState.cgColor
        case .pending:
            label.textColor = .warningState
            contentView.layer.borderColor = UIColor.warningState.cgColor
        case .disabled:
            label.textColor = .disabledState
            contentView.layer.borderColor = UIColor.disabledState.cgColor
        }

        contentView.backgroundColor = .white

        heightConstraint.constant = 18

        stackView.spacing = .spacingLayoutSmall
        stackViewLeftConstraint.constant = .spacingLayoutXSSmall
        stackViewRightConstraint.constant = -.spacingLayoutXSSmall

        label.text = text
        label.font = .bederrBold(10)
    }

    private func updateAccessibility() {
        accessibilityLabel = text
    }

    private func updateIcon() {
        guard let icon = icon else {
            iconView?.removeFromSuperview()
            iconView = nil
            return
        }
        addIconIfNeeded()
        iconView = icon
    }

    private func addIconIfNeeded() {
        guard iconView == nil else { return }
        self.iconView = icon
        stackView.insertArrangedSubview(iconView!, at: 0)
    }
}
