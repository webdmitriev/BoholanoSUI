//
//  String.ext.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 27.05.2025.
//

import Foundation
import UIKit

extension String {
    func convertHTMLBreaksToNewlines() -> String {
        return self
            .replacingOccurrences(of: "<br />", with: "\n")
            .replacingOccurrences(of: "<br>", with: "\n")
            .replacingOccurrences(of: "<br/>", with: "\n")
    }
}
