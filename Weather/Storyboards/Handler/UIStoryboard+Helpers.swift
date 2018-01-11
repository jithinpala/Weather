//
//  UIStoryboard+Helpers.swift
//  Next5
//
//  Created by Jithin on 21/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import UIKit

extension UIStoryboard {

    /// Returns an instance of the main storyboard
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    static func launchStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "LanuchScreen", bundle: Bundle.main)
    }

    static func homeStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Home", bundle: Bundle.main)
    }    
    
}
