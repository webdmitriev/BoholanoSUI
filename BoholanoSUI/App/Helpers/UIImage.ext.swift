//
//  UIImage.ext.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 26.05.2025.
//

import SwiftUI

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }
}

