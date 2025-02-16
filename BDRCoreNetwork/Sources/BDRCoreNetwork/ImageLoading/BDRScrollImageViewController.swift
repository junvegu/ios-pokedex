//
//  File.swift
//  
//
//  Created by Junior on 26/11/22.
//

import Foundation
import UIKit
import Alamofire
public enum BDRScrollImageTypeContent {
    case staticImage(UIImage)
    case urlImage(String)
}
public class BDRScrollImageBuilder {
    public static func createView(_ type: BDRScrollImageTypeContent, title: String = "") -> BDRScrollImageViewAdjust {
        let vc = BDRScrollImageViewController(type: type)
        vc.navigationItem.title = title
        return vc
    }
}
public class BDRScrollImageViewAdjust: UIViewController { }
public class BDRScrollImageViewController: BDRScrollImageViewAdjust {
    private let typeContent: BDRScrollImageTypeContent
    
    // MARK: - Component
    private lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .medium)
      view.color = .black
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    private lazy var scrollView: BDRScrollImageView = {
        let view = BDRScrollImageView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(type: BDRScrollImageTypeContent){
        self.typeContent = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implement coder ")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupImage()
    }
    
    private func setupScrollView() {
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        view.addSubview(indicatorView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicatorView.hidesWhenStopped = true
    }
    
    private func setupImage() {
        switch typeContent {
        case .staticImage(let image):
            self.scrollView.display(image: image)
        case .urlImage(let urlPath):
            downloaded(url: urlPath)
        }
    }
    
    private func downloaded(url: String) {
        indicatorView.startAnimating()
        UIImageView.loadingImage(url: url) { [weak self] response in
            self?.indicatorView.stopAnimating()
            self?.scrollView.display(image: response ?? UIImage())
        }
      }
}
