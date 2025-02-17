//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//

import Foundation
import Foundation
import BDRUIComponents
import BDRModel
import BDRCoreNetwork
import UIKit


class PKSetupModulesFacade: NSObject{
    static let shared = PKSetupModulesFacade()
    private var modules: [BDRModule] = []
    
    func setupModules() {
        BDRCoreNetwork.setup(ConfigBDRNetwork())
        BDRUIComponents.setup(config: ConfigRecipesTheme())
        modules = [BDRUIComponents.sharedInstance]
        setupTestEnviroment()
        BDRUIAppereanceManager.sharedInstance.setupAppereance()
    }
    
    
    private func setupTestEnviroment() {
#if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-UITests") {
            UIView.setAnimationsEnabled(false)
        }
#endif
    }
}

struct ConfigBDRNetwork: BDRCoreNetworkParameters {
    var apiKeyApp: String {
        "(not set)"
    }
    
    var appId: String {
        "-"
    }
    
    var urlBase: String {
        "https://pokeapi.co/api/"
    }
}

struct ConfigRecipesTheme: BDRUIKitAppereance {
    var boldItalic: UIFont {
        UIFont(name: "Montserrat-Light", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    }
    
    var tabBarTintColor: UIColor {
        UIColor(named: "ColorPrimary") ?? .gray
    }
    
    var barButtonTintColor: UIColor {
        UIColor(named: "ThemeTintColor") ?? .black
    }
    
    var primaryColor: UIColor {
        UIColor(named: "ColorPrimary") ?? .gray
    }
    
    var buttonColor: UIColor {
        UIColor(named: "ColorPrimary") ?? .gray
    }
    
    var disabledButtonColor: UIColor {
        UIColor.gray
    }
    
    var secondaryColor: UIColor {
        UIColor(named: "BackgroundColor") ?? .black
    }
    
    var accentColor: UIColor {
        UIColor.black
    }
    
    var regularFont: UIFont {
        UIFont(name: "Montserrat-Medium", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    var boldFont: UIFont {
        UIFont(name: "Montserrat-Bold", size: UIFont.systemFontSize) ?? UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
    }
    
    var lightFont: UIFont {
        UIFont(name: "Montserrat-Light", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    }
    
    var italicFont: UIFont {
        UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
    }
    
    
}
