//
//  StringExtension.swift
//  JBDictionay
//
//  Created by Jithin on 5/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    /// Convert the first character of string to caps
    ///
    /// - Returns: Converted string
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
