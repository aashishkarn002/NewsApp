//
//  Image+Extension.swift
//  NewsAPP
//
//  Created by Aashish on 8/25/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
extension UIImage {
    static func download(from url: String, completion: @escaping (UIImage) -> ()) {
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            let urlStr = url.replacingOccurrences(of: " ", with: "%20")
            let urlRequest = URLRequest(url: URL(string: urlStr)!)
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    
                    imageCache.setObject(image, forKey: url as NSString)
                    completion(image)
                }
                if error != nil {
                    
                    return
                }
            }
            task.resume()
        }
    }
}
