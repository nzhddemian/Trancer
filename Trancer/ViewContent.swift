//
//  ViewContent.swift
//  draw_2
//
//  Created by Demian on 19/01/2020.
//  Copyright © 2020 Demian Production. All rights reserved.
//

import UIKit

class ViewContent: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.view.backgroundColor = .black
        // Do any additional setup after loading the view.
        
        
        setupBackbutton(self.view.bounds)
        buttonback.addTarget(self, action: #selector(ViewContent.play), for: .touchUpInside)
        self.view.addSubview(buttonback)
        
    }
    
    func ppulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.2
    pulse.fromValue = 1.0
    pulse.toValue = 0.95
    pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    buttonback.layer.add(pulse, forKey: nil)
    }
  
    
    
    let buttonback = UIButton(type: UIButton.ButtonType.custom)
       func setupBackbutton(_ framee:CGRect){
           let width = framee.width/2
           let height = framee.height/10
          
            buttonback.frame = CGRect(x: width * 1.8 - (height * 0.2), y: (height * 8), width: height * 0.4, height: height * 0.4)
            buttonback.titleLabel?.font = UIFont(name: "Wingdings 3", size: height * 0.3)
           buttonback.backgroundColor = .gray    //  UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
                  buttonback.layer.cornerRadius = height * 0.05
                  buttonback.layer.borderColor = UIColor.white.cgColor
                  buttonback.layer.borderWidth = 0.5
                  //let fnt = UIFont(name: "Wingdings 3.ttf", size: 25)
                 
                  buttonback.titleLabel?.textColor = .white
                 
              
                  buttonback.setTitle(":", for: .normal)
        
           
       }
    
    
    
    
    
    @objc fileprivate func play(){
                   ppulsate()
                    
       self.dismiss(animated: true, completion: {});
        self.navigationController?.popViewController(animated: true);
                  }
    
}
