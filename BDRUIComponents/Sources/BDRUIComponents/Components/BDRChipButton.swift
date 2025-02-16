//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 9/08/24.
//

import Foundation
import UIKit
public class BDRChipButton: UIControl {
    // MARK: - Types
    public enum Category: String, CaseIterable {
        case filter
        case choice
        case action
        case selective
    }

    public enum Anatomy: String, CaseIterable {
        case leftIcon
        case `default`
        case rightIcon
    }

    // MARK: - Public Vars
    public var text: String {
        didSet { update() }
    }

    public var category: Category {
        didSet { update() }
    }

    public var anatomy: Anatomy {
        didSet { update() }
    }

    public var icon: UIImage? {
        didSet { update() }
    }

    public var didTouchUpInside: (() -> Void)?

    public var didChangePressed: (() -> Void)?

    // MARK: States
    override public var isEnabled: Bool {
        didSet { update() }
    }

    public var isPressed: Bool {
        get { isHighlighted }
        set { isHighlighted = newValue }
    }

    /// Button changes to the `selected` appearance.
    override public var isSelected: Bool {
        didSet { update() }
    }

    // MARK: - Overrides

    override public var isHighlighted: Bool {
        didSet { pressedChanged() }
    }

    // MARK: - Private Vars

    private enum Constants {
        static let accessibilityId = "chip_button_control"
    }

    private let contentView = UIView()
    private let stackView = UIStackView()
    private let label = UILabel()
    private var iconView: UIImageView?
    private var iconSelectedView: UIImageView?
    private var iconSelectiveChevronView: UIImageView?

    private var contentViewHeightConstraint: NSLayoutConstraint!

    private var stackViewLeftConstraint: NSLayoutConstraint!
    private var stackViewRightConstraint: NSLayoutConstraint!

    private var shouldBeInteractive: Bool {
        isEnabled
    }

    private var canHaveLeftIcon: Bool {
        category == .choice
        || category == .action
    }

    private var canHaveRightIcon: Bool {
        category == .action
    }

    private var canHaveSelectedIcon: Bool {
        category == .filter
    }

    private var canHaveSelectiveChevronIcon: Bool {
        category == .selective
    }

    // MARK: - Inits

    public convenience init() {
        self.init(category: .action)
    }

    public init(category: Category,
                text: String = "",
                anatomy: Anatomy = .default,
                icon: UIImage? = nil) {
        self.category = category
        self.text = text
        self.icon = icon
        self.anatomy = anatomy
        super.init(frame: .zero)
        setupView()
    }

    public required init?(coder: NSCoder) {
        self.category = .action
        self.text = ""
        self.icon = nil
        self.anatomy = .default
        super.init(coder: coder)
        setupView()
    }

    override public convenience init(frame: CGRect) {
        self.init()
    }
}

// MARK: - Private Methods

private extension BDRChipButton {
    // MARK: Setups

    func setupView() {
        setupContentView()
        setupStackView()
        setupLabel()
        setupTargets()
        setupAccessibility()
        update()
    }

    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            contentViewHeightConstraint,
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackViewLeftConstraint = stackView.leftAnchor.constraint(
            equalTo: contentView.leftAnchor
        )
        stackViewRightConstraint = stackView.rightAnchor.constraint(
            equalTo: contentView.rightAnchor
        )
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackViewLeftConstraint,
            stackViewRightConstraint
        ])
    }

    func setupLabel() {
        //label.requireHuggingAndCompression()
        stackView.addArrangedSubview(label)
        label.font = .bederrBold(10)
    }

    private func setupAccessibility() {
        isAccessibilityElement = true
        accessibilityHint = ""
        accessibilityIdentifier = Constants.accessibilityId
        accessibilityTraits = .button
    }

    func setupTargets() {
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }

    @objc
    func touchUpInside() {
        didTouchUpInside?()
    }

    // MARK: Update

    func update() {
        updateLabel()
        updateIcon()
        updateState()
    }

    func updateLabel() {
        label.text = text
    }

    func updateIcon() {
        iconView?.removeFromSuperview()
        iconView = nil

        if canHaveSelectiveChevronIcon {
            updateSelectiveChevronIcon()
            return
        }

        guard let icon = icon else {
            return
        }

        let iconView = UIImageView()

        switch anatomy {
        case .leftIcon:
            if canHaveLeftIcon {
                stackView.insertArrangedSubview(iconView, at: 0)
                self.iconView = iconView
            }
        case .default:
            break
        case .rightIcon:
            if canHaveRightIcon {
                stackView.addArrangedSubview(iconView)
                self.iconView = iconView
            }
        }
        self.iconView?.image = icon
    }

    func updateSelectedIcon(for state: State) {
        guard canHaveSelectedIcon, isSelected else {
            iconSelectedView?.removeFromSuperview()
            iconSelectedView = nil
            return
        }
        if iconSelectedView == nil {
            let iconSelectedView = UIImageView()
            stackView.addArrangedSubview(iconSelectedView)
            self.iconSelectedView = iconSelectedView
        }
        iconSelectedView?.image = UIImage()
    }

    func updateSelectiveChevronIcon() {
        guard canHaveSelectiveChevronIcon else {
            iconSelectiveChevronView?.removeFromSuperview()
            iconSelectiveChevronView = nil
            return
        }
        if iconSelectiveChevronView == nil {
            let iconSelectiveChevronView = UIImageView()
            stackView.addArrangedSubview(iconSelectiveChevronView)
            self.iconSelectiveChevronView = iconSelectiveChevronView
        }
        iconSelectiveChevronView?.image = UIImage()
    }

    func pressedChanged() {
        update()
        didChangePressed?()
    }
}

// MARK: - States

private extension BDRChipButton {
    enum State {
        case enabled
        case pressed
        case disabled
    }

    func updateState() {
        let state = calculateState()
        updateSelectedIcon(for: state)
        applyStyle()
        isUserInteractionEnabled = shouldBeInteractive
    }

    func calculateState() -> State {
        if !isEnabled {
            return .disabled
        }
        if isPressed {
            return .pressed
        }
        return .enabled
    }

    func applyStyle() {
        label.textColor = .primary

        stackViewLeftConstraint.constant = .spacingLayoutXSSmall ?? 0
        stackViewRightConstraint.constant = -(.spacingLayoutXSSmall ?? 0)
        stackView.spacing = .spacingLayout2xSmall ?? 0

        contentViewHeightConstraint.constant = GlobalUISpacing.MarginSizes.medium
        contentView.backgroundColor = .primary.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = GlobalUISpacing.MarginSizes.xSmall
    }
}
