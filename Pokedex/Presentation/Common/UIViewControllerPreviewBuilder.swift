//
//  UIViewControllerPreviewBuilder.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 17/02/25.
//
#if DEBUG
import UIKit
import SwiftUI

struct ViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> ViewController
    
    init(_ viewControllerBuilder: @escaping () -> ViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
#endif
