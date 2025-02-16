//
//  File.swift
//  
//
//  Created by Junior on 14/09/22.
//

import Foundation
import UIKit

public class DropDownTextField: UITextField, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Properties
    var pickerView: UIPickerView!
    var selectedValue: NSObject? {
        didSet {
            if oldValue != self.selectedValue {
                self.text = self.selectedValue?.description
                self.sendActions(for: .editingChanged)
            }
        }
    }
    var elements: [NSObject] = [] {
        didSet {
            self.pickerView.reloadAllComponents()
        }
    }
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupPickerView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPickerView()
    }
    
    // MARK: - Private
    func setupPickerView() {
        self.pickerView = UIPickerView()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.inputView = self.pickerView
        self.clearButtonMode = .never
        if (self.placeholder == nil || self.placeholder == "") {
            self.placeholder = NSLocalizedString("Seleccione", comment: "Select")
        }
        self.addTarget(self, action:#selector(self.dropDownTextFieldDidBeginEditing(_:)), for:.editingDidBegin)
        self.layer.borderColor = UIColor.clear.cgColor
        self.font = UIFont.bederrRegular(16)
    }
    
    // MARK: - Public
    func clearSelection() {
        self.selectedValue = nil
        self.text = ""
    }
    
    // MARK: - Actions
    @IBAction func dropDownTextFieldDidBeginEditing(_ sender:UITextField) {
        var index = NSNotFound
        for i in 0..<self.elements.count {
            if (self.elements[i].description == selectedValue?.description) {
                index = i
                break
            }
        }
        index = index != NSNotFound ? index : 0
        OperationQueue.main.addOperation {
            self.selectedValue = index == 0 ? self.elements.first : self.elements[index]
            self.pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    // MARK: - UITextField
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 0)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 0)
    }
    
    // MARK: - UITextInput
    public override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    // MARK: - UIResponder
    public override func becomeFirstResponder() -> Bool {
        self.alpha = 0.5
        return super.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        self.alpha = 1.0
        return super.resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.elements.count
    }
    
    // MARK: - UIPickerViewDelegate
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.elements[row].description
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedValue = row == 0 ? self.elements.first : self.elements[row]
    }
    
}


