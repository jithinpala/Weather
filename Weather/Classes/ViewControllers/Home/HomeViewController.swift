//
//  HomeViewController.swift
//  Weather
//
//  Created by Jithin on 9/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//


import UIKit

class HomeViewController: UIViewController {

    // MARK:- IBOutlet declaration
    @IBOutlet weak var placeListTableView: UITableView!
    @IBOutlet weak var errorMessageView: UIView!
    @IBOutlet weak var headingAnimationLabel: LTMorphingLabel!
    
    // MARK:- variable declaraion
    var placeTemperatureArray = [JBTemperature]()
    var refreshControl: UIRefreshControl!
    var animationTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        placeListTableView.rowHeight = UITableViewAutomaticDimension
        placeListTableView.estimatedRowHeight = 60
        self.customizeErrorMessageView()
        self.initializeRefeshController()
        self.fetchTemperatureOfPlaces()
        headingAnimationLabel.delegate = self
        if let effect = LTMorphingEffect(rawValue: 2) {
            headingAnimationLabel.morphingEffect = effect
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placeListTableView.isHidden = false
        if !errorMessageView.isHidden {
            errorMessageView.isHidden = true
        }
        animationTimer.invalidate()
        animationTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.animateHeaderLabel), userInfo: nil, repeats: true)
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

// MARK:- Webservice call
extension HomeViewController {
    
    /// Download weather details and show progres hud
    func fetchTemperatureOfPlaces() {

        JBProgressHUD.sharedInstance.showHUDWithMessage(message: "Loading...")
        JBWebService.sharedInstance.fetchCurrentWeatherByCityId(success: { (result) in
            JBProgressHUD.sharedInstance.hideHUD()
            if let resuts = result {
                self.placeTemperatureArray = resuts
            }
            UIView.transition(with: self.placeListTableView, duration: 0.8, options: .transitionCrossDissolve, animations: {
                self.placeListTableView.reloadData()
            }, completion: nil)
        }) { (error) in
            JBProgressHUD.sharedInstance.hideHUD()
            if((error?.errorCode)! > 0) {
                JBHelper.ShowSimpleAlertWithHandler(withMessage: (error?.errorString)!, inController: self, completionHandler: { (result) in
                    self.showErrorMessage()
                })
                return;
            }            
            JBHelper.ShowSimpleAlertWithHandler(withMessage: Alert_Webservice_Failure, inController: self, completionHandler: { (result) in
                self.showErrorMessage()
            })
        }
        
    }
    
    
    /// Method to downloaf weather details for UItableView refresh
    func fetchTemperatureOfPlacesForTableViewRefesh() {
        
        JBWebService.sharedInstance.fetchCurrentWeatherByCityId(success: { (result) in
            if let resuts = result {
                self.placeTemperatureArray = resuts
            }
            self.refreshControl.endRefreshing()
            UIView.transition(with: self.placeListTableView, duration: 0.8, options: .transitionCrossDissolve, animations: {
                self.placeListTableView.reloadData()
            }, completion: nil)
        }) { (error) in
            
            self.refreshControl.endRefreshing()
        }
        
    }
    
    
}

// MARK:- Costomize user interface
extension HomeViewController {
    
    
    
    /// Display error message
    func showErrorMessage() {
        placeListTableView.isHidden = true
        errorMessageView.isHidden = false
        errorMessageView.alpha = 0.0
        UIView.animate(withDuration: 2) {
            self.errorMessageView.alpha = 1.0
        }
    }
    
    
    /// Customize error message view
    func customizeErrorMessageView() {
        errorMessageView.layer.cornerRadius = 10.0
        errorMessageView.backgroundColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0).withAlphaComponent(0.7)
    }
    
    
    /// Initialization of UIRefreshControl
    func initializeRefeshController() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(fetchTemperatureOfPlacesForTableViewRefesh), for: .valueChanged)
        self.placeListTableView.addSubview(refreshControl)
    }
    
    func animateHeaderLabel(){
        headingAnimationLabel.text = "WEATHER"
    }
}

// MARK:- TableView Delegate and DataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Tableview section
    ///
    /// - Parameter tableView: UITableView
    /// - Returns: section cout as Int
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    /// Number of row in section
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: section number as Int
    /// - Returns: number of rows as Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard placeTemperatureArray.count > 0 else {
            return 0
        }
        return placeTemperatureArray.count
    }
    
    
    /// Create tableview cell and declare cell details
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: Indexpath for the cell
    /// - Returns: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListTableCell") as! PlaceListTableCell
        let singlePlaceTempArray = placeTemperatureArray[indexPath.row]
        cell.placeNameLabel.text = singlePlaceTempArray.placeName
        cell.highTempLabel.text  = String(describing: singlePlaceTempArray.tempMax!) + "°"
        cell.lowTempLabel.text   = String(describing: singlePlaceTempArray.tempMin!) + "°"
        return cell
    }
    
    
    /// Catch the TableViewCell touch action
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: Current indexpath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = TemperatureDetailViewController.getController()
        detailViewController.detailsTemperatureArray = placeTemperatureArray[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    /// Define the high for the row
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: Indexpath of the current cell
    /// - Returns: Float value 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: - LTMorphingLabel Delegate
extension HomeViewController: LTMorphingLabelDelegate {
    
    func morphingDidStart(_ label: LTMorphingLabel) {
        
    }
    
    func morphingDidComplete(_ label: LTMorphingLabel) {
        headingAnimationLabel.text = ""
    }
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
        
    }
}
