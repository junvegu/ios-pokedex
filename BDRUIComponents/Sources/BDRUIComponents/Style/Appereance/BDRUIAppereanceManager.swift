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
        
      
       // UINavigationBar.appearance().scrollEdgeAppearance = appearance
        setupTabBarItems()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.bederrRegular(14)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
    }
    
    
    func setupTabBarAppereance() {
        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = BDRUIComponents.sharedInstance.config.tabBarTintColor
        tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    func setupBarButtonItemAppereance() {
        let barButtonApperance = UIBarButtonItem.appearance()
        barButtonApperance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.bederrRegular(14)], for: UIControl.State())
        barButtonApperance.tintColor = BDRUIComponents.sharedInstance.config.barButtonTintColor

        if #available(iOS 13.0, *) {
            let backButtonAppearance = UIBarButtonItemAppearance()
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.label]
            UINavigationBar.appearance().standardAppearance.backButtonAppearance = backButtonAppearance
        } else {
            UINavigationBar.appearance().tintColor =  BDRUIComponents.sharedInstance.config.barButtonTintColor
            UINavigationBar.appearance().barTintColor = .white
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar.appearance()

        if #available(iOS 13.0, *) {
            UINavigationBar.appearance().tintColor = .black
            let appearance = UINavigationBarAppearance()
           // appearance.configureWithOpaqueBackground()
           // appearance.backgroundColor = .white
          //  appearance.shadowColor = nil
            appearance.titleTextAttributes = [.foregroundColor: UIColor.label,
                                              .font: UIFont.bederrBold(16)]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label,
                                                   .font: UIFont.bederrBold(24)]
            UINavigationBar.appearance().standardAppearance = appearance
         //   UINavigationBar.appearance().compactAppearance = appearance
          //  UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            
         //   UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black ,  NSAttributedString.Key.font: UIFont.bederrBold(16)], for: .normal)
            
          //  navigationBar.standardAppearance = appearance
          //  navigationBar.scrollEdgeAppearance = appearance
            navigationBar.prefersLargeTitles = false
        } else {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().barTintColor = UIColor.black
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label ,  NSAttributedString.Key.font: UIFont.bederrBold(16)]
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.bederrBold(24)]
        }
        
          //  navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
           // navigationBar.layer.shadowRadius = 2.0
          //  navigationBar.layer.shadowOpacity = 0.8
           // navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
           // navigationBar.layer.masksToBounds = false
          //  navigationBar.prefersLargeTitles = true
        //    navigationBar.isTranslucent = true
    
    }
    
    func setupTabBarItems() {
        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.white
    }
}
