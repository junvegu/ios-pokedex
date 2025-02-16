//
//  File.swift
//  
//
//  Created by Junior on 6/03/23.
//

import UIKit

public class BDRDatePicker: BDRCustomControl {
    @IBOutlet var contentBackground: UIView!
    @IBOutlet public weak var dateTextFields: BDRMaterialTextField!
    @IBOutlet public weak var dateField: DateField!
    
    public var placeholder: String = "" {
        didSet {
            dateTextFields.placeholder = placeholder
        }
    }
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.loadViewFromNib()
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.loadViewFromNib()
        self.commonInit()
    }
    
    private func commonInit() {
        dateTextFields.text = "    "
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    @IBAction func didSelectPicker(_ sender: Any) {
        
    }
}

public class DateField: UITextField {
    var privateDate: Date?
    public var date: Date? {
        set {
            privateDate = newValue
            if !isFirstResponder && newValue != nil{
                datePicker.setDate(newValue!, animated: false)
            }
        }
        get {
            return privateDate
        }
    }
    
    private lazy var dateFormatter = DateFormatter()
    
    @IBInspectable var dateFormat: String = "dd/MM/yyyy" {
        didSet {
            dateFormatter.dateFormat = dateFormat
        }
    }
    
    lazy var datePicker = UIDatePicker()
    
    var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            datePicker.datePickerMode = datePickerMode
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.maximumDate = date
        
        
        datePicker.timeZone =  TimeZone.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = dateFormat
        if date != nil {
            datePicker.setDate(date!, animated: false)
        }
        datePicker.addTarget(self, action: #selector(didSelectDate(_:)), for: .valueChanged)
        datePicker.datePickerMode = datePickerMode
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.timeZone = .current
        inputView = datePicker
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.font = UIFont.bederrRegular(16)
        
        
    }
    
    
    @objc private func didSelectDate(_ sender: UIDatePicker) {
        date = sender.date
        text = dateFormatter.string(from: sender.date)
        self.sendActions(for: .editingChanged)
    }
    
    public func refreshDate(date: Date) {
        text = dateFormatter.string(from: date)
    }
    
    
}
