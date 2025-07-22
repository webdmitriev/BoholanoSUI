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
    
    func decodingHTMLEntities() -> String {
        var result = self
        // Сначала заменяем HTML-сущности
        let entities = [
            "&#8217;": "'",
            "&quot;": "\"",
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "\\n": "\n"  // Добавляем обработку переносов строк
        ]
        
        for (entity, replacement) in entities {
            result = result.replacingOccurrences(of: entity, with: replacement)
        }
        
        // Дополнительная обработка HTML-тегов (если нужно)
        result = result.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        
        return result
    }
}
