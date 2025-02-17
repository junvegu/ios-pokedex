//
//  BDRUIAppereanceManager.swift
//  
//
//  Created by Junior on 31/10/22.
//

import UIKit
public extension UIViewController {
    func setNavigationStyle() {
     /*   let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                          .font: UIFont.bederrBold(16)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                               .font: UIFont.bederrBold(24)]
     
        navigationItem.standardAppearance = appearance
        let scrollEdges = appearance.copy()
        scrollEdges.shadowColor = .clear
        navigationItem.scrollEdgeAppearance = scrollEdges
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backButtonTitle = ""*/

    }
}

public class BDRUIAppereanceManager : NSObject{
    
    // MARK: - Properties
    public static let sharedInstance = BDRUIAppereanceManager()
    
    // MARK: - Public
    public func setupAppereance() {
        setupTabBarAppereance()
        setupBarButtonItemAppereance()
        setupNavigationBar()
        setupTabBarItems()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .dynamicSearchBarBackground
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .dynamicLabelColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.bederrRegular(14)

    }
    
    
    func setupTabBarAppereance() {
        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = BDRUIComponents.sharedInstance.config.tabBarTintColor
        tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    func setupBarButtonItemAppereance() {
        let barButtonAppearance = UIBarButtonItem.appearance()
        
        barButtonAppearance.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.bederrRegular(14),
            NSAttributedString.Key.foregroundColor: UIColor.dynamicLabelColor
        ], for: .normal)
        
        barButtonAppearance.tintColor = UIColor.dynamicLabelColor

        if #available(iOS 13.0, *) {
            let backButtonAppearance = UIBarButtonItemAppearance()
            backButtonAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.dynamicLabelColor,
                .font: UIFont.bederrRegular(14)
            ]
            UINavigationBar.appearance().standardAppearance.backButtonAppearance = backButtonAppearance
        } else {
            UINavigationBar.appearance().tintColor = UIColor.dynamicLabelColor
            UINavigationBar.appearance().barTintColor = UIColor.dynamicBackgroundColor
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
    }

    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar.appearance()

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .dynamicBackgroundColor
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.dynamicLabelColor,
                .font: UIFont.bederrBold(16)
            ]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.dynamicLabelColor,
                .font: UIFont.bederrBold(24)
            ]

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().tintColor = .dynamicLabelColor
            
            navigationBar.prefersLargeTitles = false
        } else {
            UINavigationBar.appearance().tintColor = .dynamicLabelColor
            UINavigationBar.appearance().barTintColor = .dynamicBackgroundColor
            navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.dynamicLabelColor,
                .font: UIFont.bederrBold(16)
            ]
            navigationBar.largeTitleTextAttributes = [
                .foregroundColor: UIColor.dynamicLabelColor,
                .font: UIFont.bederrBold(24)
            ]
        }
    }
    
    func setupTabBarItems() {
        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.white
    }
}
extension UIColor {
    static var dynamicLabelColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
    static var dynamicBackgroundColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
    }
    
    static var dynamicSearchBarBackground: UIColor {
           return UIColor { traitCollection in
               return traitCollection.userInterfaceStyle == .dark ? UIColor.darkGray : UIColor.white
           }
       }
}
