//
//  ImageCache.swift
//  Randomuser
//
//  Created by David Lopez on 26/9/22.
//

import Foundation
import UIKit

final class ImageCache {
    static let sharedInstance: ImageCache = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 32 * 3 // 3 pages of results
    }
 
    func cacheImage(url: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: url))
    }
    
    func isImageCached(imageUrl: String) -> Bool {
        return cache.object(forKey: NSString(string: imageUrl)) != nil
    }
    
    func getCachedImage(imageUrl: String) -> UIImage? {
        return cache.object(forKey: NSString(string: imageUrl))
    }
}
