//
//  JBConstant.swift
//  Next5
//
//  Created by Jithin on 21/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import Foundation

public enum APIRequestType: String {
    case get     = "GET"
    case post    = "POST"
    case head    = "HEAD"
    case put     = "PUT"
}

// MARK:- Date format
let DateFormat_General  = ["yyyy-MM-dd HH:mm:ss.SSSS","dd-MM-yyy HH:mm:ss","MM/dd/yyy hh:mm:ss a","dd MMM yyyy HH:mm:ss","yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"]

public enum placeList: String {
    case sydney     = "Sydney"
    case melbourne  = "Melbourne"
    case brisbane   = "Brisbane"
}

public enum placeCodeID: String {
    case sydney     = "2147714"
    case melbourne  = "4163971"
    case brisbane   = "2174003"
}
