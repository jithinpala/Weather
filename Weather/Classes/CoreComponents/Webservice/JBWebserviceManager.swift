
//
//  JBWebserviceManager.swift
//  Next5
//
//  Created by Jithin on 21/12/17.
//  Copyright © 2017 Jithinpala. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JBWebserviceManager {
    static var sharedWebserviceManager = JBWebserviceManager()
    let sessionExpiryErrorCode = 50015
    
    
    /// Check network connection availability
    fileprivate var isReachable: Bool {
        if let reachability =  Reachability()?.currentReachabilityStatus{
            return reachability != .notReachable
        }
        return false
    }
    
    
    
    /// To connect web services
    ///
    /// - Parameters:
    ///   - cityId: City id to find weather
    ///   - parameters: webservice parameters
    ///   - apiRequestType: API request type
    ///   - success: call back handler for success response
    ///   - failure: call back handler for error response
    func sendRequestToServer(cityId: String, parameters: [String : AnyObject]?, apiRequestType:APIRequestType, success: @escaping (_ responseData: JSON) -> Void, failure: @escaping (_ error: JBAPIError?) -> Void) {
        
        guard isReachable else {
            failure(JBAPIError(errCode: 503, errString: "Network not accessible.", err: nil))
            return
        }
            
        let httpMethod = getHttpRequestType(apiRequestType: apiRequestType)
        let parameterEncoding:ParameterEncoding
        if(apiRequestType == APIRequestType.post) {
            
            parameterEncoding = JSONEncoding.default
        }
        else {
            
            parameterEncoding = URLEncoding.default
        }
        
        var headers:HTTPHeaders?
        let fullUrl = "\(API_BASE_URL)\(cityId)&APPID=\(APP_API_KEY)"
        Alamofire.request(fullUrl,
            method: httpMethod,
            parameters: parameters != nil ? parameters! : nil,
            encoding: parameterEncoding,
            headers: headers).responseJSON { (response: DataResponse<Any>) in
                
                switch response.result {
                case .failure(let error):
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        
                        print(responseString) // Print error data
                    }
                    
                    failure(JBAPIError(err: error))
                    return
                    
                case .success(let responseObject):
                    
                    guard let jsonData = responseObject as? [String: AnyObject]
                        
                        else {
                            
                            /// No response data from server
                            let anErr : JBAPIError = JBAPIError(errCode: 1, errString: "No response data.", err: nil)
                            failure(anErr)
                            return
                    }                    
                    let jsonSwifty = JSON(data: response.data!)
                    success(jsonSwifty)
                    return
                }
        }
    }
    
    
    /// To connect web services
    ///
    /// - Parameters:
    ///   - serviceName: Service requested
    ///   - success: call back handler for success response
    ///   - failure: call back handler for error response
    func sendResponse(serviceName: String, success: @escaping (_ jsonArray: AnyObject) -> Void, failure: @escaping (_ error: JBAPIError?)->Void ) {
        
        guard isReachable else {
            let apiError = JBAPIError(errCode: 501, errString: "Network not accessible.", err: nil)
            failure(apiError)
            return
        }
        
        let urlString = API_BASE_URL + serviceName        
        guard let serviceUrl = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: serviceUrl, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    let jsonResult: AnyObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    GlobalMainQueue.async {
                        success(jsonResult)
                    }                    
                } catch {
                    let error = JBAPIError(errCode: 1, errString: "No response data", err: nil)
                    GlobalMainQueue.async {
                        failure(error)
                    }                    
                }
            }
        })
        task.resume()
        
        
    }
    
    /// To connect web services
    ///
    /// - Parameters:
    ///   - serviceName: Service requested
    ///   - success: call back handler for success response
    ///   - failure: call back handler for error response
    func sendResponseGetAsDictionary(serviceName: String, success: @escaping (_ jsonArray: [String: Any]) -> Void, failure: @escaping (_ error: JBAPIError?)->Void ) {
        
        guard isReachable else {
            let apiError = JBAPIError(errCode: 501, errString: "Network not accessible.", err: nil)
            failure(apiError)
            return
        }
        
        let urlString = API_BASE_URL + serviceName
        guard let serviceUrl = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        // or let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: serviceUrl, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    let jsonResult: AnyObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    if let dictionary = jsonResult as? [String: Any] {
                        GlobalMainQueue.async {
                            success(dictionary)
                        }                        
                    }
                    
                    
                } catch {
                    let error = JBAPIError(errCode: 1, errString: "No response data", err: nil)
                    GlobalMainQueue.async {
                        failure(error)
                    }
                }
            }
        })
        task.resume()
        
        
    }    

    
    /// To get HTTPMethod request type
    ///
    /// - parameter apiRequestType: api request type
    ///
    /// - returns: HTTPMethod
    private func getHttpRequestType(apiRequestType:APIRequestType) -> (HTTPMethod) {
        
        switch apiRequestType {
        case .get:
            
            return HTTPMethod.get;
            
        case .post:
            
            return HTTPMethod.post;
        case .head:
            
            return HTTPMethod.head;
            
        case .put:
            
            return HTTPMethod.put;
        }
    }
}
