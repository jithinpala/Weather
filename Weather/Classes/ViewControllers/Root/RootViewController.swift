//
//  RootViewController.swift
//  Weather
//
//  Created by Jithin on 9/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    // MARK:- IBOutlet declaration
    @IBOutlet weak var lightingImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var headingAnimationLabel: LTMorphingLabel!
    
    // MARK:- Variable declaration
    var homeNavController: UINavigationController?
    var imgListArray = [UIImage]()
    var launchTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //headingLabel.alpha = 0.0
        //self.headingLabelAnimation()
        headingAnimationLabel.delegate = self
        headingAnimationLabel.morphingDuration = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let effect = LTMorphingEffect(rawValue: 6) {
            headingAnimationLabel.morphingEffect = effect
            self.changeHeaderTextValue()
        }
    }
    
    func changeHeaderTextValue() {
        headingAnimationLabel.text = "WEATHER"
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

extension RootViewController {
    
    /// To remove current navigation controller
    ///
    /// - Parameter viewController: NavigationController
    func removeView(_ viewController: UINavigationController?){
        
        if let vc = viewController {
            vc.popToRootViewController(animated: false)
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
    }
    
    
    /// Animate the label
    func headingLabelAnimation() {
        UIView.animate(withDuration: 3, animations: {
            self.headingLabel.alpha = 1.0
        }) { (finished) in
            if finished {
                self.lightningAnimation()
            }
        }
    }
    
    
    /// Lightning aniation
    func lightningAnimation() {
        let image1  = UIImage(named:"lightning1.png")
        imgListArray.append(image1!)
        let image2  = UIImage(named:"lightning2.png")
        imgListArray.append(image2!)
        let image3  = UIImage(named:"lightning3.png")
        imgListArray.append(image3!)
        let image4  = UIImage(named:"lightning4.png")
        imgListArray.append(image4!)
        let image5  = UIImage(named:"lightning5.png")
        imgListArray.append(image5!)
        let image6  = UIImage(named:"lightning6.png")
        imgListArray.append(image6!)
        lightingImageView.animationImages = imgListArray
        lightingImageView.animationDuration = 1
        lightingImageView.animationRepeatCount = 1
        lightingImageView.startAnimating()        
        
        launchTimer.invalidate()
        launchTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.launchHomeScreen), userInfo: nil, repeats: false)
    }    
    
    
    
    /// Launch Home Screen
    func launchHomeScreen() {
        removeView(homeNavController)
        let homeController = HomeViewController.getController()
        homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController!.setNavigationBarHidden(true, animated: false)
        self.view.addSubview(homeNavController!.view)
        self.addChildViewController(homeNavController!)
        homeNavController!.didMove(toParentViewController: self)
    }
    
}

// MARK: - LTMorphingLabel Delegate
extension RootViewController: LTMorphingLabelDelegate {
    
    func morphingDidStart(_ label: LTMorphingLabel) {
        
    }
    
    func morphingDidComplete(_ label: LTMorphingLabel) {
        self.launchHomeScreen()
    }
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
        
    }
}
