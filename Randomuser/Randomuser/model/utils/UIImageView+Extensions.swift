//
//  UIImageView+Extensions.swift
//  Randomuser
//
//  Created by David Lopez on 19/9/22.
//

import Foundation
import UIKit

// extension to load a web image into an UIImgeView
extension UIImageView {
    func load(url: URL, placeholder: UIImage?, errorImage: UIImage?) {
        if ImageCache.sharedInstance.isImageCached(imageUrl: url.absoluteString) {
            self.image = ImageCache.sharedInstance.getCachedImage(imageUrl: url.absoluteString) ?? errorImage
        } else {
            self.image = placeholder
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        ImageCache.sharedInstance.cacheImage(url: url.absoluteString, image: image)
                    }
                } else {
                    self?.image = errorImage
                }
            }
        }
    }
}
