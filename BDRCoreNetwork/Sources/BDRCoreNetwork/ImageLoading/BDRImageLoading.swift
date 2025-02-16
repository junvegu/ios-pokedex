//
//  File.swift
//  
//
//  Created by Junior on 5/12/21.
//

import UIKit
import AlamofireImage
import Alamofire
public extension UIImageView {
    
    func loadingImage(url: String,
                      placeholder: UIImage = UIImage(),
                      transition: Bool = false) {
        guard let urlSafe = URL.init(string: url) else {
            return
        }
        if transition  {
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: self.frame.size,
                radius: 20.0
            )
            self.af.setImage(withURL: urlSafe,
                             placeholderImage: placeholder,
                             filter: filter,
                             imageTransition: .crossDissolve(0.2))
        } else {
            self.af.setImage(withURL: urlSafe, placeholderImage: placeholder)
        }
    }
    
    static func loadingImage(url: String,
                placeholder: UIImage = UIImage(),
                transition: Bool = false,
                handler: @escaping (UIImage?) -> Void)  {
        AF.request(url, method: .get).responseImage { response in
            switch response.result {
            case .success(let image):
                handler(image)
            case .failure(_):
                handler(nil)
            }
        }
    }
}
