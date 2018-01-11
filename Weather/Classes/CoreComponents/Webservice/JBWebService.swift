//
//  JBWebService.swift
//  Next5
//
//  Created by Jithin on 21/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import Foundation
import SwiftyJSON

class JBWebService {
    
    
    /// Singleton instance
    static let sharedInstance = JBWebService()
    
    
    /// Service to get weather details passing City ID
    ///
    /// - Parameters:
    ///   - success: call back handler for success response
    ///   - failure: call back handler for error response
    func fetchCurrentWeatherByCityId(success: @escaping (_ result: [JBTemperature]?) -> Void, failure: @escaping (_ error: JBAPIError?) -> Void){
        let serviceManager = JBWebserviceManager.sharedWebserviceManager
        serviceManager.sendRequestToServer(cityId: placeCodeID.sydney.rawValue, parameters: nil, apiRequestType: .get, success: { (response) in
            var fetchedWeather = [JBTemperature]()
            let sydneyTemp = JBTemperature(result: response)
            fetchedWeather.append(sydneyTemp)
            
            serviceManager.sendRequestToServer(cityId: placeCodeID.melbourne.rawValue, parameters: nil, apiRequestType: .get, success: { (response) in
                let melbourne = JBTemperature(result: response)
                fetchedWeather.append(melbourne)
                
                serviceManager.sendRequestToServer(cityId: placeCodeID.brisbane.rawValue, parameters: nil, apiRequestType: .get, success: { (response) in
                    let brisbane = JBTemperature(result: response)
                    fetchedWeather.append(brisbane)
                    success(fetchedWeather)
                }) { (error) in
                    failure(error)
                }
                
            }) { (error) in
                failure(error)
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
       
}
