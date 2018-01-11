//
//  JBAPIError.swift
//  Next5
//
//  Created by Jithin on 21/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import Foundation

class JBAPIError: Error {
    
    var errorCode: Int
    var errorString: String?
    var baseErr:Error?
    
    
    init(err:Error) {
        
        self.errorCode = 0;
        self.errorString = nil;
        self.baseErr    = err;
    }
    
    init(errCode:Int, errString:String, err:Error?) {
        
        self.errorCode = errCode;
        self.errorString = errString;
        self.baseErr    = err;
    }
}
