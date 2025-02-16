//
//  BDRMaterialTextField.swift
//  
//
//  Created by Junior on 24/07/22.
//
import UIKit

/**
 A beautiful and flexible textfield implementation with support for title label, error message and placeholder.
 */
@IBDesignable
open class BDRMaterialTextField: UITextField {
    
    public struct Paddigs {
        var textLeading: CGFloat
        var textTrailing: CGFloat
        var textTop: CGFloat
        var textBottom: CGFloat
        var titleTop: CGFloat
        var titleLeadingFromTextField: CGFloat
        var titleSpacing: CGFloat
    }
    
    open var paddings = Paddigs(
        textLeading: 15,
        textTrailing: 10,
        textTop: 5,
        textBottom: 13,
        titleTop: 0,
        titleLeadingFromTextField: 13,
        titleSpacing: 5
    ) {
        didSet {
            updateControl(false)
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    /**
     A Boolean value that determines if the language displayed is LTR.
     Default value set automatically from the application language settings.
     */
    @objc open var isLTRLanguage: Bool = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
        didSet {
            updateTextAligment()
        }
    }
    
    private func updateTextAligment() {
        if isLTRLanguage {
            textAlignment = .left
            titleLabel.textAlignment = .left
        } else {
            textAlignment = .right
            titleLabel.textAlignment = .right
        }
    }
    
    // MARK: Animation timing
    
    /// The value of the title appearing duration
    @objc dynamic open var titleFadeInDuration: TimeInterval = 0.2
    /// The value of the title disappearing duration
    @objc dynamic open var titleFadeOutDuration: TimeInterval = 0.2
    
    // MARK: Colors
    
    private var cachedTextColor: UIColor?
    
    /// A UIColor value that determines the text color of the editable text
    @IBInspectable
    override dynamic open var textColor: UIColor? {
        get {
            return cachedTextColor
        }
        set {
            cachedTextColor = newValue
            updateControl(false)
        }
    }
    
    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable dynamic open var placeholderColor: UIColor = .black54Opacity {
        didSet {
            updateTitleColor()
        }
    }
    
    /// A UIFont value that determines text color of the placeholder label
    @objc dynamic open var placeholderFont: UIFont = .bederrRegular(16) {
        didSet {
            updateTitleLabel()
        }
    }
    
    /// A UIFont value that determines the text font of the title label
    @objc dynamic open var titleFont: UIFont = .bederrRegular(16) {
        didSet {
            updateTitleLabel()
        }
    }
    
    /// A UIColor value that determines the text color of the title label when in the normal state
    @IBInspectable dynamic open var titleColor: UIColor = .black54Opacity {
        didSet {
            updateTitleColor()
        }
    }
    
    /// A UIColor value that determines the color of the outline when in the normal state
    @IBInspectable dynamic open var outlineColor: UIColor = .black54Opacity {
        didSet {
            updateOutlineLayer()
        }
    }
    
    /// A UIColor value that determines the color used for the title label and line when the error message is not `nil`
    @IBInspectable dynamic open var errorColor: UIColor = .redA400 {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the outline when error message is not `nil`
    @IBInspectable dynamic open var outlineErrorColor: UIColor? = .redA400 {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the text when error message is not `nil`
    @IBInspectable dynamic open var textErrorColor: UIColor? = .redA400 {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the title label when error message is not `nil`
    @IBInspectable dynamic open var titleErrorColor: UIColor? = .redA400 {
        didSet {
            updateColors()
        }
    }
    
    /// A UIColor value that determines the color used for the title label and line when text field is disabled
    @IBInspectable dynamic open var disabledColor: UIColor = .lightGray {
        didSet {
            updateControl()
        }
    }
    
    /// A UIColor value that determines the text color of the title label when editing
    @IBInspectable dynamic open var selectedTitleColor: UIColor = .primary {
        didSet {
            updateTitleColor()
        }
    }
    
    /// A UIColor value that determines the color of the outline in a selected state
    @IBInspectable dynamic open var selectedOutlineColor: UIColor = .primary {
        didSet {
            updateOutlineLayer()
        }
    }
    
    // MARK: Line height
    
    /// A CGFloat value that determines the height for the outline when the control is in the normal state
    @IBInspectable dynamic open var outlineWidth: CGFloat = 0.5 {
        didSet {
            updateOutlineLayer()
            setNeedsDisplay()
        }
    }
    
    /// A CGFloat value that determines the width for the outline when the control is in a selected state
    @IBInspectable dynamic open var selectedOutlineWidth: CGFloat = 1.0 {
        didSet {
            updateOutlineLayer()
            setNeedsDisplay()
        }
    }
    
    // MARK: View components
    
    /// The internal `CAShapeLayer` to display the outline.
    open var outlineLayer: CAShapeLayer!
    
    /// The internal `UILabel` that displays the selected, deselected title or error message based on the current state.
    open var titleLabel: UILabel!

    open var errorLabel: UILabel!

    // MARK: Properties
    
    /**
     The formatter used before displaying content in the title label.
     This can be the `title`, `selectedTitle` or the `errorMessage`.
     The default implementation returns the text as is.
     */
    open var titleFormatter: ((String?) -> String?) = { (text: String?) -> String? in
        return text
    }
    
    /**
     Identifies whether the text object should hide the text being entered.
     */
    override open var isSecureTextEntry: Bool {
        get {
            return super.isSecureTextEntry
        }
        set {
            super.isSecureTextEntry = newValue
            fixCaretPosition()
        }
    }
    
    /// A String value for the error message to display.
    @IBInspectable
    open var errorMessage: String? {
        didSet {
            updateControl(true)
        }
    }
    
    /// The backing property for the highlighted property
    private var _highlighted: Bool = false
    
    /**
     A Boolean value that determines whether the receiver is highlighted.
     When changing this value, highlighting will be done with animation
     */
    override open var isHighlighted: Bool {
        get {
            return _highlighted
        }
        set {
            _highlighted = newValue
            updateTitleColor()
            updateOutlineLayer()
        }
    }
    
    /// A Boolean value that determines whether the textfield is being edited or is selected.
    open var editingOrSelected: Bool {
        return super.isEditing || isSelected
    }
    
    /// A Boolean value that determines whether the receiver has an error message.
    open var hasErrorMessage: Bool {
        return !(errorMessage ?? "").isEmpty
    }
    
    private var _renderingInInterfaceBuilder: Bool = false
    
    /// The text content of the textfield
    @IBInspectable
    override open var text: String? {
        didSet {
            updateControl(false)
        }
    }
    
    private var _placeholderText: String?
    
    
    /**
     The String to display when the input field is empty.
     The placeholder can also appear in the title label when both `title` `selectedTitle` and are `nil`.
     */
    @IBInspectable
    override open var placeholder: String? {
        didSet {
            _placeholderText = placeholder
            attributedPlaceholder = NSAttributedString(
                string: "",
                attributes: [.foregroundColor: UIColor.clear]
            ) // hiding plceholder because we're using title label
            
            setNeedsDisplay()
            updateTitleLabel()
        }
    }
    
    /// The String to display when the textfield is editing and the input is not empty.
    @IBInspectable open var selectedTitle: String? {
        didSet {
            updateControl()
        }
    }
    
    /// The String to display when the textfield is not editing and the input is not empty.
    @IBInspectable open var title: String? {
        didSet {
            updateControl()
        }
    }
    
    // Determines whether the field is selected. When selected, the title floats above the textbox.
    open override var isSelected: Bool {
        didSet {
            updateControl(true)
        }
    }
    
    // MARK: - Initializers
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initTextField()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter aDecoder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTextField()
    }
    
    private final func initTextField() {
        borderStyle = .none
        createTitleLabel()
        createOutlineLayer()
        updateColors()
        addEditingChangedObserver()
        updateTextAligment()
        updateOutlineLayer()
        createErrorLabel()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func addEditingChangedObserver() {
        self.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    /**
     Invoked when the editing state of the textfield changes. Override to respond to this change.
     */
    @objc open func editingChanged() {
        updateControl(true)
        updateTitleLabel(true)
    }
    
    // MARK: create components
    
    private func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        titleLabel.numberOfLines = 1
        
        addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    private func createErrorLabel() {
        let errorLabel = UILabel()
        errorLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        errorLabel.font = .bederrRegular(10)
        errorLabel.textColor = errorColor
        errorLabel.numberOfLines = 1
        
        addSubview(errorLabel)
        self.errorLabel = errorLabel
        errorLabel.text = ""
        self.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
                errorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            ])
    }
    
    
    private func createOutlineLayer() {
        
        if outlineLayer == nil {
            let layer = CAShapeLayer()
            self.outlineLayer = layer
            configureDefaultOutlineWidth()
        }
        
        layer.addSublayer(outlineLayer)
    }
    
    private func configureDefaultOutlineWidth() {
        let onePixel: CGFloat = 1.0 / UIScreen.main.scale
        outlineWidth = 2.0 * onePixel
        selectedOutlineWidth = 2.0 * self.outlineWidth
    }
    
    // MARK: Responder handling
    
    /**
     Attempt the control to become the first responder
     - returns: True when successfull becoming the first responder
     */
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateControl(true)
        return result
    }
    
    /**
     Attempt the control to resign being the first responder
     - returns: True when successfull resigning being the first responder
     */
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateControl(true)
        return result
    }
    
    /// update colors when is enabled changed
    override open var isEnabled: Bool {
        didSet {
            updateControl()
        }
    }
    
    // MARK: - View updates
    
    private func updateControl(_ animated: Bool = false) {
        updateColors()
        updateOutlineLayer()
        updateTitleLabel(animated)
    }
    
    private func updateOutlineLayer() {
        guard let outlineLayer = outlineLayer else {
            return
        }
        
        outlineLayer.frame = outlineLayerRectForBounds(bounds)
        updateOutlineColor()
        
        let path = isTitleVisible() ? editingOutlinePath() : defaultOutlinePath()
        path.lineWidth = editingOrSelected ? selectedOutlineWidth : outlineWidth
        outlineLayer.updatePath(path)
    }
    
    // MARK: - Color updates
    
    /// Update the colors for the control. Override to customize colors.
    open func updateColors() {
        updateOutlineColor()
        updateTitleColor()
        updateTextColor()
    }
    
    private func updateOutlineColor() {
        guard let outlineLayer = outlineLayer else {
            return
        }
        
        outlineLayer.fillColor = UIColor.clear.cgColor
        if !isEnabled {
            outlineLayer.strokeColor = disabledColor.cgColor
        } else if hasErrorMessage {
            outlineLayer.strokeColor = (outlineErrorColor ?? errorColor).cgColor
        } else {
            outlineLayer.strokeColor = (editingOrSelected ? selectedOutlineColor : outlineColor).cgColor
        }
    }
    
    private func updateTitleColor() {
        guard let titleLabel = titleLabel else {
            return
        }
        
        if !isEnabled {
            titleLabel.textColor = disabledColor
          //  self.textColor = .lightGray
        } else if hasErrorMessage {
            titleLabel.textColor = titleErrorColor ?? errorColor
        } else {
            if editingOrSelected || isHighlighted {
                titleLabel.textColor = selectedTitleColor
            } else {
                titleLabel.textColor = isTitleVisible() ? titleColor : placeholderColor
            }
        }
    }
    
    private func updateTextColor() {
        if !isEnabled {
            super.textColor = disabledColor
        } else if hasErrorMessage {
            super.textColor = textErrorColor ?? errorColor
        } else {
            super.textColor = cachedTextColor
        }
    }
    
    // MARK: - Title handling
    
    private func updateTitleLabel(_ animated: Bool = false) {
        guard let titleLabel = titleLabel else {
            return
        }
        
        var titleText: String?
        if hasErrorMessage {
            errorLabel.text = titleFormatter(errorMessage!)
            titleText = titleOrPlaceholder()
        } else {
            errorLabel.text = ""
            if editingOrSelected {
                titleText = selectedTitleOrTitlePlaceholder()
                if titleText == nil {
                    titleText = titleOrPlaceholder()
                }
            } else {
                titleText = titleOrPlaceholder()
            }
        }
        titleLabel.text = titleText
        titleLabel.font = isTitleVisible() ? .bederrLight(12) : placeholderFont
        
        updateTitleVisibility(animated)
        updateOutlineLayer()
    }
    
    private var _titleVisible: Bool = false
    
    /*
     *   Set this value to make the title visible
     */
    open func setTitleVisible(
        _ titleVisible: Bool,
        animated: Bool = false,
        animationCompletion: ((_ completed: Bool) -> Void)? = nil
    ) {
        if _titleVisible == titleVisible {
            return
        }
        _titleVisible = titleVisible
        updateTitleColor()
        updateTitleVisibility(animated, completion: animationCompletion)
    }
    
    /**
     Returns whether the title is being displayed on the control.
     - returns: True if the title is displayed on the control, false otherwise.
     */
    open func isTitleVisible() -> Bool {
        return hasText || hasErrorMessage || _titleVisible || editingOrSelected
    }
    
    private func updateTitleVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let frame: CGRect = titleLabelRectForBounds(bounds, editing: isTitleVisible())
        let updateBlock = { () -> Void in
            self.titleLabel.frame = frame
        }
        if animated {
            #if swift(>=4.2)
            let animationOptions: UIView.AnimationOptions = .curveEaseOut
            #else
            let animationOptions: UIViewAnimationOptions = .curveEaseOut
            #endif
            let duration = isTitleVisible() ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }
    
    // MARK: - UITextField text/placeholder positioning overrides
    
    /**
     Calculate the rectangle for the textfield when it is not being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        
        let textLeadingPadding = isLTRLanguage
            ? paddings.textLeading
            : paddings.textTrailing
        
        let rect = CGRect(
            x: superRect.origin.x + textLeadingPadding,
            y: titleHeight + paddings.textTop + paddings.titleTop,
            width: superRect.size.width - (paddings.textLeading + paddings.textTrailing),
            height: superRect.size.height - titleHeight - selectedOutlineWidth - (paddings.textBottom + paddings.textTop + paddings.titleTop)
        )
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        
        let textLeadingPadding = isLTRLanguage
            ? paddings.textLeading
            : paddings.textTrailing
            
        let rect = CGRect(
            x: superRect.origin.x + textLeadingPadding,
            y: titleHeight + paddings.textTop + paddings.titleTop,
            width: superRect.size.width - (paddings.textLeading + paddings.textTrailing),
            height: superRect.size.height - titleHeight - selectedOutlineWidth - (paddings.textBottom + paddings.textTop + paddings.titleTop)
        )
        return rect
    }
    
    // MARK: - Positioning Overrides
    
    /**
     Calculate the bounds for the title label. Override to create a custom size title field.
     - parameter bounds: The current bounds of the title
     - parameter editing: True if the control is selected or highlighted
     - returns: The rectangle that the title label should render in
     */
    open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        let xOffset = isLTRLanguage
            ? paddings.titleLeadingFromTextField
            : bounds.width - (paddings.titleLeadingFromTextField + titleWidth())
        
        if editing {
            return CGRect(
                x: xOffset,
                y: paddings.titleTop,
                width: titleWidth(),
                height: titleHeight()
            )
        }
        return CGRect(
            x: xOffset,
            y: titleHeight() + paddings.titleTop + paddings.textTop,
            width: titleWidth(),
            height: titleHeight()
        )
    }
    
    /**
     Calculate the bounds for the outline layer of the control.
     Override to create a custom size outline layer in the textbox.
     - parameter bounds: The current bounds of text field
     - returns: The rectangle that the outline layer should render in
     */
    open func outlineLayerRectForBounds(_ bounds: CGRect) -> CGRect {
        let topOffset = paddings.titleTop + (titleHeight() / 2)
        let height = bounds.height - topOffset
        return CGRect(
            x: 0,
            y: topOffset,
            width: bounds.size.width,
            height: height
        )
    }
    
    /**
     Calculate the height of the title label.
     -returns: the calculated height of the title label. Override to size the title with a different height
     */
    open func titleHeight() -> CGFloat {
        if let titleLabel = titleLabel,
            let font = titleLabel.font {
            return font.lineHeight
        }
        return 15.0
    }
    
    /**
     Calculate the width of the title label.
     -returns: the calculated width of the title label. Override to size the title with a different width
     */
    open func titleWidth() -> CGFloat {
        if let titleLabel = titleLabel {
            return min(titleLabel.systemLayoutSizeFitting(
                UIView.layoutFittingCompressedSize
            ).width, bounds.width * 0.8)
        }
        return 15.0
    }
    
    /**
     Calcualte the height of the textfield.
     -returns: the calculated height of the textfield. Override to size the textfield with a different height
     */
    open func textHeight() -> CGFloat {
        guard let font = self.font else {
            return 0.0
        }
        
        return font.lineHeight + 7.0
    }
    
    // MARK: - Layout
    
    /// Invoked when the interface builder renders the control
    override open func prepareForInterfaceBuilder() {
        if #available(iOS 8.0, *) {
            super.prepareForInterfaceBuilder()
        }
        
        borderStyle = .none
        
        isSelected = true
        _renderingInInterfaceBuilder = true
        updateControl(false)
        invalidateIntrinsicContentSize()
    }
    
    /// Invoked by layoutIfNeeded automatically
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = titleLabelRectForBounds(
            bounds,
            editing: isTitleVisible() || _renderingInInterfaceBuilder
        )
        updateOutlineLayer()
    }
    
    /**
     Calculate the content size for auto layout
     
     - returns: the content size to be used for auto layout
     */
    override open var intrinsicContentSize: CGSize {
        return CGSize(
            width: bounds.size.width,
            height: paddings.titleTop + titleHeight() + paddings.textTop + textHeight() + paddings.textBottom
        )
    }
    
    // MARK: - Helpers
    
    private func titleOrPlaceholder() -> String? {
        guard let title = title ?? _placeholderText else {
            return nil
        }
        return titleFormatter(title)
    }
    
    private func selectedTitleOrTitlePlaceholder() -> String? {
        guard let title = selectedTitle ?? title ?? _placeholderText else {
            return nil
        }
        return titleFormatter(title)
    }
    
    // Outline
    
    @IBInspectable dynamic open var outlineRadius: CGFloat = 5 {
        didSet {
            updateControl(false)
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    open var roundedCornersInNormalState: UIRectCorner = .allCorners {
        didSet {
            updateControl(false)
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    open func defaultOutlinePath() -> UIBezierPath {
        return UIBezierPath(
            roundedRect: outlineLayer.bounds,
            byRoundingCorners: roundedCornersInNormalState,
            cornerRadii: CGSize(
                width: outlineRadius,
                height: outlineRadius
            )
        )
    }
    
    open func editingOutlinePath() -> UIBezierPath {
        return roundedPath(
            from: outlineLayer.bounds,
            withTextSpace: titleWidth() + paddings.titleSpacing,
            leadingOffset: paddings.titleLeadingFromTextField - (paddings.titleSpacing / 2),
            outlineRadius: outlineRadius,
            isLTRLanguage: isLTRLanguage
        )
    }
    let button = UIButton(type: .custom)

    open func enablePasswordToggle(){
        
        button.setImage(UIImage.loadFromAssets("eye_open"), for: .normal)
        button.setImage(UIImage.loadFromAssets("eye_off"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: -12, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
        button.alpha = 0.4
    }
    
    @objc
    open func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        button.isSelected.toggle()
    }
}

private extension UITextField {
    /// Moves the caret to the correct position by removing the trailing whitespace
    func fixCaretPosition() {
        // Moving the caret to the correct position by removing the trailing whitespace
        // http://stackoverflow.com/questions/14220187/uitextfield-has-trailing-whitespace-after-securetextentry-toggle
        
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }
}

private extension CAShapeLayer {
    func updatePath(_ outlinePath: UIBezierPath) {
        lineWidth = outlinePath.lineWidth
        lineCap = CAShapeLayerLineCapFromCGLineCap(outlinePath.lineCapStyle)
        lineJoin = CAShapeLayerLineJoinFromCGLineJoin(outlinePath.lineJoinStyle)
        miterLimit = outlinePath.miterLimit
        path = outlinePath.cgPath
    }
}

private func CAShapeLayerLineCapFromCGLineCap(_ lineCap: CGLineCap) -> CAShapeLayerLineCap {
    switch lineCap {
    case .butt: return .butt
    case .round: return .round
    case .square: return .square
    @unknown default: return .butt
    }
}

private func CAShapeLayerLineJoinFromCGLineJoin(_ lineJoin: CGLineJoin) -> CAShapeLayerLineJoin {
    switch lineJoin {
    case .bevel: return .bevel
    case .miter: return .miter
    case .round: return .round
    @unknown default: return .bevel
    }
}

private func roundedPath(
    from f: CGRect,
    withTextSpace textSpace: CGFloat,
    leadingOffset offset: CGFloat,
    outlineRadius: CGFloat,
    isLTRLanguage: Bool
) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = outlineRadius
    let yOffset = f.origin.y
    let xOffset = f.origin.x
    
    // Draw the path
    path.move(to: CGPoint(x: radius + xOffset, y: yOffset))
    if isLTRLanguage {
        path.addLine(to: CGPoint(x: offset + xOffset, y: yOffset))
        path.move(to: CGPoint(x: textSpace + offset + xOffset, y: yOffset))
        path.addLine(to: CGPoint(x: f.size.width - radius + xOffset, y: yOffset))
    } else {
        path.addLine(to: CGPoint(x: xOffset + (f.size.width - (offset + textSpace)), y: yOffset))
        path.move(to: CGPoint(x: xOffset + (f.size.width - offset), y: yOffset))
        path.addLine(to: CGPoint(x: xOffset + (f.size.width - radius), y: yOffset))
    }
    
    path.addArc(
        withCenter: CGPoint(x: f.size.width - radius + xOffset, y: radius + yOffset),
        radius: radius,
        startAngle: -CGFloat(CGFloat.pi / 2),
        endAngle: 0,
        clockwise: true)
    path.addLine(to: CGPoint(x: f.size.width + xOffset, y: f.size.height - radius + yOffset))
    path.addArc(
        withCenter: CGPoint(
            x: f.size.width - radius + xOffset,
            y: f.size.height - radius + yOffset),
        radius: radius,
        startAngle: 0,
        endAngle: -CGFloat((CGFloat.pi * 3) / 2),
        clockwise: true)
    path.addLine(to: CGPoint(x: radius + xOffset, y: f.size.height + yOffset))
    path.addArc(
        withCenter: CGPoint(x: radius + xOffset, y: f.size.height - radius + yOffset),
        radius: radius,
        startAngle: -CGFloat((CGFloat.pi * 3) / 2),
        endAngle: -CGFloat.pi,
        clockwise: true)
    path.addLine(to: CGPoint(x: xOffset, y: radius + yOffset))
    path.addArc(
        withCenter: CGPoint(x: radius + xOffset, y: radius + yOffset),
        radius: radius,
        startAngle: -CGFloat.pi,
        endAngle: -CGFloat(CGFloat.pi / 2),
        clockwise: true)
    
    return path
}

// MARK: Default color constants
public extension UIColor {
    static let blueA700 = UIColor(red: 0 / 255, green: 145 / 255, blue: 234 / 255, alpha: 1)
    static let redA400 = UIColor(red: 255 / 255, green: 23 / 255, blue: 68 / 255, alpha: 1)
    static let black54Opacity = UIColor.black.withAlphaComponent(0.46)
}
