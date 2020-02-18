//
//  ViewController.swift
//  Trancer
//
//  Created by Demian on 04/12/2019.
//  Copyright © 2019 Demian Production. All rights reserved.
//


import UIKit


class Main: UIViewController {

  var heightt = CGFloat()
        var widthh = CGFloat()
       
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .black
            heightt = self.view.frame.height
            widthh = self.view.frame.width
            setupCamButtonn()
            
            // Do any additional setup after loading the view.
        }
        let buttonF = UIButton(type: UIButton.ButtonType.custom)
        func setupCamButtonn(){
            
            buttonF.frame = CGRect(x: widthh * 0.5, y: heightt * 0.5, width: heightt * 0.08, height: heightt * 0.08)
            
            buttonF.backgroundColor = UIColor(red: 0.0, green: 0.7, blue: 0.8, alpha: 0.7)
            buttonF.layer.cornerRadius = heightt * 0.01
            
            buttonF.addTarget(self, action: #selector(self.nextView), for: .touchUpInside)
            self.view.addSubview(buttonF)
        }
        
        ///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT
        
        func pulsatee() {
         let pulse = CASpringAnimation(keyPath: "transform.scale")
         pulse.duration = 0.2
         pulse.fromValue = 1.0
         pulse.toValue = 0.95
         pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
         buttonF.layer.add(pulse, forKey: nil)
         }

        @objc fileprivate func nextView(){
            pulsatee()
            let selectView = UINavigationController()
           
            selectView.modalTransitionStyle = .crossDissolve
    //selectView.modalPresentationStyle = UIModalPresentationStyle.popover
            //selectView.isNavigationBarHidden = true
            self.navigationController!.pushViewController(CamViewController(), animated: true)
            //present(selectView, animated: true, completion: nil)
            
        }
        
        
    
    //ORIENTATION
            ////////
            struct AppUtility {
                
                static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
                    
                    if let delegate = UIApplication.shared.delegate as? AppDelegate {
                        delegate.orientationLock = orientation
                    }
    }
                
                /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
                static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
                    
                    self.lockOrientation(orientation)
                    
                    UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                }
                
            }
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                
                // AppUtility.lockOrientation(.portrait)
                // Or to rotate and lock
                AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
                
            }
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                
                // Don't forget to reset when view is being removed
                AppUtility.lockOrientation(.all)
            }
        //////////ORIENTATION
    
    
}

