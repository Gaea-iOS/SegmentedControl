//
//  UIImage+Extension.swift
//  Pods
//
//  Created by 王小涛 on 2016/12/20.
//
//

import Foundation

public extension UIImage {
    
    static func fromColor(_ color: UIColor, withSize size: CGSize) -> UIImage? {
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
