//
//  KDKViewControllers+StoryboardIdentifiers.swift
//  Next5
//
//  Created by Jithin on 21/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import Foundation
import UIKit



extension HomeViewController: StoryboardIdentifiable {
    
    class func getController() -> HomeViewController {
        return HomeViewController.instantiateViewControllerFromStoryboard(UIStoryboard.homeStoryboard()) as! HomeViewController
    }
    
    class func storyboardIdentifier() -> String {
        return "HomeViewController"
    }
    
}

extension TemperatureDetailViewController: StoryboardIdentifiable {
    
    class func getController() -> TemperatureDetailViewController {
        return TemperatureDetailViewController.instantiateViewControllerFromStoryboard(UIStoryboard.homeStoryboard()) as! TemperatureDetailViewController
    }
    
    class func storyboardIdentifier() -> String {
        return "TemperatureDetailViewController"
    }
    
}
 

