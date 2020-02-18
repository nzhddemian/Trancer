//
//  swtcher.swift
//  draw_2
//
//  Created by Demian on 21/12/2019.
//  Copyright © 2019 Demian Production. All rights reserved.
//

import UIKit

class SliderFx: UISlider {


    
 
        var lineWidth = CGFloat()
      
  
      
     var width = CGFloat()
      
     var height = CGFloat()
      
    
    
    func sliderSetupA(_ rect: CGRect){
        lineWidth = rect.width * 0.02
        width = rect.width
        height = rect.height
        self.layer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        let drRect =  CGRect(x: width*0.015, y: height * 0.125 , width: width/3.8, height: height * 0.3)
       // let drRect =  CGRect(x: width-width/3.5, y: height * 0.08 , width: width/3.8, height: height * 0.25)      width*0.015 + width/3.8  , y:height * 0.125 +height * 0.3
        //let drRect = CGRect(x: width-width/2.8, y: height -  height * 0.11, width: width/3, height: height * 0.03)
       self.frame = drRect
       self.addTarget(self, action: #selector(SliderFx.changeVlaueA(_:)), for: .valueChanged)
       self.trackRect(forBounds: self.frame)
           self.layer.cornerRadius = 4.0
        //self.TrackImage
       // let trackImg = cols(drRect).resizableImage(withCapInsets: .zero)
        self.setTrackCols()
        self.setTumbRedArrow()
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.black.cgColor
          // self.setMaximumTrackImage(trackImg, for: .normal)
       // self.setMinimumTrackImage(trackImg, for: .normal)
        //   self.setThumbImage(arrow(CGRect(x: 0, y: 0, width: lineWidth*10, height: drRect.height)), for: .normal)
        //self.minimumValueImage = arrow(CGRect(x: 0, y: 0, width: lineWidth*12, height: drRect.height))
              
              
                 
              
                                 self.maximumValue = 1.0
                                 self.minimumValue = -1.0
        self.setValue(1.0, animated: false)
                                
       }
    
    func sliderSetupB(_ rect: CGRect){
           lineWidth = rect.width * 0.02
           width = rect.width
           height = rect.height
        self.layer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
       
        let drRect = CGRect(x: width*0.015, y: height * 0.55, width: width/3.8, height: height * 0.3)
       // let drRect =  CGRect(x: width-width/3.5, y: height * 0.39, width: width/3.8, height: height * 0.25)
          self.frame = drRect
        self.setTrackColss()
               self.setTumbRedArrow()
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.black.cgColor
          self.addTarget(self, action: #selector(SliderFx.changeVlaueB(_:)), for: .valueChanged)
          self.trackRect(forBounds: self.frame)
              self.layer.cornerRadius = 4.0
             
                               
                 
                 
                    
                 
                                    self.maximumValue = 1.0
                                    self.minimumValue = 0
                                   self.setValue(0.5, animated: false)
                                   
          }
  
    
    
       var valA = Float(1)
       var valB = Float(1)
       var valC = Float()
    
    
    @objc func changeVlaueA(_ sender: UISlider) {
            valA = sender.value
        //ViewController.label.text =  String(self.buttView.sliderA.valA)
       // print(valA)
       }
   
    @objc func changeVlaueB(_ sender: UISlider) {
         valB = sender.value
     //print(valB)
    }
    
    
    
    
    
    
      
    
}



extension UISlider{
   
    func setTrackColss() {
        let lineWidth = self.frame.width * 0.01
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.white.cgColor)
      
        let cols = CGFloat(20)
       // lineWidth = rect.width*0.01
         context?.setLineWidth(lineWidth)
        context?.setLineCap(.round)
        let w = (self.frame.width - lineWidth*6)/cols - lineWidth/4
              let len = Int(cols)
               let h = CGFloat()
        for i in 0...len{
            //if(i%10 == 0){h = rect.height/2}else if(i%5 == 0){h = (rect.height)/3}else{h = rect.height/4}
          let point = CGPoint(x:  CGFloat(i ) * w + lineWidth*3.8,y: 0)
             let toPoint = CGPoint(x: CGFloat(i ) * w + lineWidth*3.8,y:  h + CGFloat(i)/2)
               context?.move(to:point )
               context?.addLine(to: toPoint )
            }
        context?.strokePath()
        var imageColss = UIImage()
          imageColss = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: .zero)
        UIGraphicsEndImageContext()
        
        // colss(drRect).resizableImage(withCapInsets: .zero)
                      self.setMaximumTrackImage(imageColss, for: .normal)
                 self.setMinimumTrackImage(imageColss, for: .normal)
                     
          
         // return imageColss!
          
          
        }
    func setTrackCols() {
        let lineWidth = self.frame.width * 0.01
        UIGraphicsBeginImageContext(self.frame.size)
         let context = UIGraphicsGetCurrentContext()
         context?.setStrokeColor(UIColor.white.cgColor)
       
         let cols = CGFloat(20)
        // lineWidth = rect.width*0.01
          context?.setLineWidth(lineWidth)
         context?.setLineCap(.round)
        let w = (self.frame.width - lineWidth*5)/cols  - lineWidth/8
               let len = Int(cols)
                var h = CGFloat()
         for i in 0...len{
            if(i%10 == 0){h = self.frame.height/2}else if(i%5 == 0){h = (self.frame.height)/3}else{h = self.frame.height/4}
             let point = CGPoint(x:  CGFloat(i ) * w + lineWidth*3.8,y: 0)
             let toPoint = CGPoint(x: CGFloat(i ) * w + lineWidth*3.8,y:  h)
                context?.move(to:point )
                context?.addLine(to: toPoint )
             }
         context?.strokePath()
         let imageCols = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: .zero)
         UIGraphicsEndImageContext()
        // return imageCols!
        self.setMaximumTrackImage(imageCols, for: .normal)
                        self.setMinimumTrackImage(imageCols, for: .normal)
         }
    
    
    func setTumbRedArrow()  {
        let cgsZ = CGSize(width: self.frame.width/10, height: self.frame.height)
        UIGraphicsBeginImageContext(cgsZ)
        let w = cgsZ.width
        let h = cgsZ.height
           let context = UIGraphicsGetCurrentContext()
              context?.setLineCap(.round)
           context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(cgsZ.width*0.12)
        context?.move(to: CGPoint(x: cgsZ.width/2, y: 0))
         context?.addLine(to: CGPoint(x: w/2, y: h))
              
         
              context?.setFillColor(UIColor.red.cgColor)
             
              
              context?.addLine(to: CGPoint(x: w - w/3, y: h))
              context?.addLine(to: CGPoint(x: w/2, y: h/1.7))
          context?.addLine(to: CGPoint(x: w/3, y: h))
               context?.addLine(to: CGPoint(x: w/2, y: h))
           context?.strokePath()
              
           let imageArrow = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
         
         self.setThumbImage(imageArrow, for: .normal)
        
           }
      
    
    
    
    
    
    
    
}
