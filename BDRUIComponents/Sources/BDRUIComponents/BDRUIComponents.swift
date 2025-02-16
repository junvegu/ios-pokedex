import UIKit
import BDRModel
import IQKeyboardManagerSwift
public class BDRUIComponents: BDRModule {
    public static let sharedInstance = BDRUIComponents()
    
    public var config: BDRUIKitAppereance!
    
   
    public init () { }
    
    public class func setup(config: BDRUIKitAppereance) {
        BDRUIComponents.sharedInstance.config = config
        IQKeyboardManager.shared.enable = true
        BDRUIAppereanceManager.sharedInstance.setupAppereance()
    }
}

public protocol BDRUIKitAppereance {
    var primaryColor: UIColor { get }
    var buttonColor: UIColor { get }
    var disabledButtonColor: UIColor { get }
    var tabBarTintColor: UIColor { get }
    var barButtonTintColor: UIColor { get }

    var secondaryColor: UIColor { get }
    var accentColor: UIColor { get }
    var regularFont: UIFont { get }
    var boldFont: UIFont { get }
    var lightFont: UIFont { get }
    var italicFont: UIFont { get }
    var boldItalic: UIFont { get }
}

extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UIViewController {
   
    open override func awakeAfter(using coder: NSCoder) -> Any? {
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
            return super.awakeAfter(using: coder)
        } else {
            return nil
        }
    }
}
