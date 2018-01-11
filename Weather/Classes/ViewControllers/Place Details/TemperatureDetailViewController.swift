//
//  TemperatureDetailViewController.swift
//  Weather
//
//  Created by Jithin on 9/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import UIKit

class TemperatureDetailViewController: UIViewController {

    // MARK:- IBOutlet declaration
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    // MARK:- variable declaraion
    var detailsTemperatureArray: JBTemperature!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.displayValuesInUserInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TemperatureDetailViewController {
    
    
    
    /// Display values in the user interface
    func displayValuesInUserInterface() {
        temperatureLabel.text = String(describing: detailsTemperatureArray.temperature!)
        placeNameLabel.text = detailsTemperatureArray.placeName
        descriptionLabel.text = detailsTemperatureArray.skyDescription!.capitalizingFirstLetter()
        tempHighLabel.text = String(describing: detailsTemperatureArray.tempMax!) + "°"
        tempLowLabel.text = String(describing: detailsTemperatureArray.tempMin!) + "°"
        sunRiseLabel.text = DateUtils.sharedInstane.convertWeatherTimeDate(milliSeonds: detailsTemperatureArray.sunrise!)
        sunSetLabel.text = DateUtils.sharedInstane.convertWeatherTimeDate(milliSeonds: detailsTemperatureArray.sunset!)
        humidityLabel.text = String(describing: detailsTemperatureArray.humidity!)
        windSpeedLabel.text = String(describing: detailsTemperatureArray.windSpeed!)
    }
    
    @IBAction func backArrowButtontapAction(sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
