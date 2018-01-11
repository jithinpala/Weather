//
//  JBTemperature.swift
//  Weather
//
//  Created by Jithin on 9/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


/// Temperature Model class
class JBTemperature: NSObject {

    var placeId: Int?
    var placeName: String?
    var temperature: Double?
    var tempMin: Double?
    var tempMax: Double?
    var humidity: Double?
    var skyDescription: String?
    var windSpeed: Double?
    var sunrise: Double?
    var sunset: Double?
    
    
    init(result: JSON) {
        super.init()
        self.placeId = result["id"].intValue
        self.placeName = result["name"].stringValue
        self.temperature = result["main"]["temp"].doubleValue        
        self.tempMin = result["main"]["temp_min"].doubleValue
        self.tempMax = result["main"]["temp_max"].doubleValue
        self.humidity = result["main"]["humidity"].doubleValue
        for (_,subJson):(String, JSON) in result["weather"] {
            self.skyDescription = subJson["description"].stringValue
        }
        self.windSpeed = result["wind"]["speed"].doubleValue
        self.sunrise = result["sys"]["sunrise"].doubleValue
        self.sunset = result["sys"]["sunset"].doubleValue
    }
    
}
