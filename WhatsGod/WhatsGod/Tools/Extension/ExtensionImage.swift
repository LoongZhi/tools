//
//  ExtensionImageView.swift
//  WhatsGod
//
//  Created by imac on 11/11/19.
//  Copyright © 2019 L. All rights reserved.
//

import UIKit
extension UIImage {
    
    //压缩图片
    public func compressImage(_ image: UIImage, toByte maxLength: Int) -> UIImage {
        var compression: CGFloat = 1
        guard var data = image.jpegData(compressionQuality: compression),
            data.count > maxLength else { return image }
        
        // Compress by size
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = image.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < maxLength { return resultImage }
        
        // Compress by size
        var lastDataLength: Int = 0
        while data.count > maxLength, data.count != lastDataLength {
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(maxLength) / CGFloat(data.count)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                    height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        return resultImage
    }
    
    func compressImageMid(maxLength: Int) -> Data? {
        var compression: CGFloat = 1
            guard var data = self.jpegData(compressionQuality: 1) else { return nil }
        print("压缩前kb: \( Double((data.count)/1024))")
        if data.count < maxLength {
            return data
        }
       
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        var resultImage: UIImage = UIImage(data: data)!
         print("压缩后kb", data.count / 1024, "KB")
        if data.count < maxLength {
        return data
        }
        return data
    }
    
}

