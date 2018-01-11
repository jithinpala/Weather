//
//  KDKStoryboardIdentifierHandlerType.swift
//  Next5
//
//  Created by Jithin on 21/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import UIKit

/**
 A protocol specific to the Lister sample that represents the segue identifier
 constraints in the app. Every view controller provides a segue identifier
 enum mapping. This protocol defines that structure.
 
 We also want to provide implementation to each view controller that conforms
 to this protocol that helps box / unbox the segue identifier strings to
 segue identifier enums. This is provided in an extension of `SegueHandlerType`.
 */
public protocol StoryboardIdentifierHandlerType {
    /**
     Gives structure to what we expect the segue identifiers will be. We expect
     the `SegueIdentifier` mapping to be an enum case to `String` mapping.
     **/
//    enum StoryboardIdentifier: String {
//        case LoginView = "LoginViewController"
//        case ShowHelp    = "ShowHelp"
//    }

    
    associatedtype StoryboardIdentifier: RawRepresentable
    
    
}

/**
 A protocol specific to the Lister sample that represents the segue identifier
 constraints in the app. Every view controller provides a segue identifier
 enum mapping. This protocol defines that structure.
 
 We also want to provide implementation to each view controller that conforms
 to this protocol that helps box / unbox the segue identifier strings to
 segue identifier enums. This is provided in an extension of `SegueHandlerType`.
 */
public protocol StoryboardIdentifiable {
    
   
    static func storyboardIdentifier() -> String
    
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    public static func instantiateViewControllerFromStoryboard(_ storyBoard : UIStoryboard) -> UIViewController? {
        return storyBoard.instantiateViewController(withIdentifier: storyboardIdentifier())
    }
}
