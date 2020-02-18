//
//  Buttons.swift
//  draw_2
//
//  Created by Demian on 14/01/2020.
//  Copyright © 2020 Demian Production. All rights reserved.
//

import UIKit

class Buttons:  UIView{
    
    var picker = UIPickerView()
   var txt = "String()"
    func setupPicker(){
       
        self.picker.selectRow(0, inComponent: 0, animated: false)
        
        picker.layer.borderWidth = 2
        picker.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        picker.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        picker.setValue(0.9, forKeyPath: "alpha")
       
        //picker.frame = CGRect(x:     self.frame.width -  self.frame.width * 0.275 , y: self.frame.minY + self.frame.height*0.15 , width:  self.frame.width * 0.275, height: self.frame.height * 0.7)
        picker.frame = CGRect(x:     self.frame.width -  self.frame.width * 0.275 , y: self.frame.minY + self.frame.height*0.25 , width: self.frame.height * 0.5   , height: self.frame.width * 0.275)
        picker.transform = CGAffineTransform(rotationAngle: .pi / 2)
        picker.frame.origin = CGPoint(x:     self.frame.width -  self.frame.width * 0.275 , y: self.frame.minY + self.frame.height*0.25)
        }
    let sliderA = SliderFx()
   let sliderB = SliderFx()
          // let sliderC = SliderFx()
           
           var cntrlRect = CGRect()
    
    
    
    
    
    
    ////////////////////////////BUTTTON
          let button = UIButton(type: UIButton.ButtonType.custom)
             let buttonn = UIButton(type: UIButton.ButtonType.custom)
            let buttonnn = UIButton(type: UIButton.ButtonType.custom)
            let buttonnnn = UIButton(type: UIButton.ButtonType.custom)
    let photoImg = UIImage(named: "photo.png")
           let videoImg = UIImage(named: "video.png")
    
    func setupCamButton(){
         let width = self.frame.width
         let height = self.frame.height
       
        buttonnn.frame = CGRect(x:self.frame.width * 0.59, y: height/2 - (height * 0.2), width: height * 0.4, height: height * 0.4)
        buttonnn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        buttonnn.layer.cornerRadius = height * 0.05
        buttonnn.layer.borderColor = UIColor.white.cgColor
        buttonnn.layer.borderWidth = 0.5
        //let fnt = UIFont(name: "Wingdings 3.ttf", size: 25)
        buttonnn.titleLabel?.font = UIFont(name: "Wingdings", size: height * 0.3)
        buttonnn.titleLabel?.textColor = .white
       
    
        buttonnn.setTitle("", for: .normal)
        
        
        buttonn.frame = CGRect(x: width * 0.38 - (height * 0.2), y:  (height * 0.3) - height * 0.175, width: height * 0.42  , height: height * 0.32)
        buttonn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        buttonn.layer.cornerRadius = height * 0.05
       // buttonn.layer.borderWidth = 0.5
       // buttonn.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
       
        
         buttonn.titleLabel?.textColor = UIColor.gray.withAlphaComponent(0.5)
        
        
        buttonnnn.frame = CGRect(x: width * 0.38 - (height * 0.2), y: (height * 0.4) + height * 0.1, width: height * 0.4, height: height * 0.4)
        buttonnnn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
       // buttonnnn.layer.cornerRadius = height * 0.05
        // buttonnnn.layer.borderWidth = 0.5
        buttonnnn.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        let rottImg = UIImage(named: "rotateimg.png")
        buttonnnn.setImage(rottImg, for: .normal)
        buttonnnn.titleLabel?.textColor = UIColor.gray.withAlphaComponent(0.5)
        
        
        
        
        button.frame = CGRect(x: width  * 0.5 - (height * 0.2), y: height/2 - (height * 0.2), width: height * 0.4, height: height * 0.4)
        button.backgroundColor = UIColor(red: 0.7, green: 0.1, blue: 0.0, alpha: 0.9)
        button.layer.cornerRadius = height * 0.1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
         button.layer.borderWidth = 0.5
        self.addSubview(button)
        self.addSubview(buttonn)
        self.addSubview(buttonnn)
        self.addSubview(buttonnnn)
        self.addSubview(picker)
       }
           ////////////////////////////BUTTTON
    
    
    
    
    
    
  func setupBUtt(_ frame:CGRect ){
    self.layer.cornerRadius = frame.height*0.125
       self.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
   self.layer.borderWidth = 1.0
    self.layer.borderColor = UIColor.black.cgColor
   
   if let filter = CIFilter(name:"CIInvert") {
              filter.name = "myFilter"
              self.layer.backgroundFilters = [filter]
             
          }
    self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    self.frame = frame
     self.setPhImg()
    sliderA.sliderSetupA(frame)
    sliderB.sliderSetupB(frame)
    self.addSubview(sliderB)
    self.addSubview(sliderA)
    setupPicker()
    setupCamButton()
    
    print(self.txt)
    
    }
    
 

    
    
    
}




extension CamViewController:   UIPickerViewDataSource , UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                          return 1
                      }
                      
                      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                        pickerView.subviews.forEach({

                           $0.isHidden = $0.frame.height < 10.0
                        })
                       
                        return filters.count
                      }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                          return filters[row]
                      }
                      
                      func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
                        let attributedString = NSAttributedString(string: filters[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
                        
                       //let attributedString = NSAttributedString(string: filters[row], attributes: [NSAttributedString.Key.font : UIFont.init(name: "Menlo", size: 20)])
                       return attributedString
                      }
                 
                   func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
                    return self.buttView.picker.frame.width*0.7
                   }
    
                    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                        
                     
                      filterSwither =  filters[row]    //UIFont.familyNames[row]
                     
                    }
    
    //    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return self.buttView.frame.height*0.3
//    }
                  
                   
                   func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
                       var pickerLabel: UILabel? = (view as? UILabel)
                       if pickerLabel == nil {
                           pickerLabel = UILabel()
                           
                        pickerLabel?.font = UIFont(name:"Menlo", size: self.buttView.frame.height*0.25)
                          
                           pickerLabel?.textAlignment = .center
                       }
                       pickerLabel?.text = filters[row]
                    pickerLabel?.textColor = UIColor.white
                    pickerLabel?.transform = CGAffineTransform(rotationAngle: .pi / -2)
                    return pickerLabel!
                   }
    
}

extension UIView{
   
    func setPhImg() {
        let width = self.frame.width
        let height = self.frame.height
        let lineWidth = self.frame.height * 0.005
        
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        
   
       
         context?.setLineWidth(lineWidth)
       // context?.setLineCap(.round)
      
              
       
        context?.move(to:CGPoint(x:  width*0.015 + width/3.8  , y: height * 0.23) )
         context?.addLine(to:CGPoint(x:  width*0.015 + width/3.8 + 5  , y: height * 0.23) )
          context?.addLine(to:CGPoint(x:  width*0.015 + width/3.8 + 5  , y: height * 0.05) )
        context?.addLine(to: CGPoint(x:  width -  width * 0.275 - 5 , y:  height*0.05) )
          context?.addLine(to: CGPoint(x: width -  width * 0.275 - 5 , y:  height/2) )
         context?.addLine(to: CGPoint(x: width -  width * 0.275  , y:  height/2 ) )
        //self.frame.width -  self.frame.width * 0.275
         //////FROM SLIDERS TO FILTERS down
        context?.move(to:CGPoint(x:  width*0.015 + width/3.8  , y: height * 0.76) )
        context?.addLine(to:CGPoint(x:  width*0.015 + width/3.8 + 10  , y: height * 0.76) )
        context?.addLine(to: CGPoint(x:  width*0.015 + width/3.8 + 10, y:  height*0.1) )
       context?.addLine(to: CGPoint(x:  width -  width * 0.275 - 10 , y:  height*0.1) )
        context?.addLine(to: CGPoint(x: width -  width * 0.275 - 10 , y:  height/2 + 5) )
         context?.addLine(to: CGPoint(x: width - width * 0.275  , y:  height/2 + 5) )
        
        
         //////CAM TO REC
        context?.move(to:CGPoint(x: width * 0.38 + (height * 0.1) , y: height * 0.35 ) )
         context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.35) )
         context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.5 -  height * 0.05) )
          context?.addLine(to:CGPoint(x: width * 0.5 , y: height * 0.5 -  height * 0.05))
        
        ///FROM CAM TO FOLDER
        context?.move(to:CGPoint(x: width * 0.38 + (height * 0.1) , y: height * 0.3 ) )
        context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.2) , y: height * 0.3) )
        context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.2) , y: height * 0.25) )
         context?.addLine(to:CGPoint(x: width * 0.57 + height*0.2 , y: height * 0.25))
        context?.addLine(to:CGPoint(x: width * 0.57 + height*0.2  , y: height * 0.35))
        
        ///FROM CAM TO FILTERS
        context?.move(to:CGPoint(x: width * 0.38 + (height * 0.1) , y: height * 0.25 ) )
        context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.25) )
        context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.15) )
        context?.addLine(to:CGPoint(x: width -  width * 0.275 - 15 , y: height * 0.15) )
        context?.addLine(to:CGPoint(x: width -  width * 0.275 - 15 , y: height * 0.5 + 10) )
        context?.addLine(to:CGPoint(x: width -  width * 0.275  , y: height * 0.5 + 10) )
        
        //FROM ROTATE TO FILTERS
        context?.move(to:CGPoint(x: width * 0.38 + (height * 0.1) , y: height * 0.7 + 5 ) )
          context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.7 + 5) )
        context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.8) )
        context?.addLine(to:CGPoint(x: width -  width * 0.275 - 10, y: height * 0.8) )
        context?.addLine(to:CGPoint(x: width -  width * 0.275 - 10, y: height/2 + 15) )
        context?.addLine(to:CGPoint(x: width -  width * 0.275 , y: height/2 + 15) )
        // x: width * 0.38 - (height * 0.15), y: (height * 0.4) + height * 0.15, width: height * 0.3, height: height * 0.3)
        
         //FROM ROTATE TO REC
        context?.move(to:CGPoint(x: width * 0.38 + (height * 0.1) , y: height * 0.65  ) )
                 context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.65) )
              context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) , y: height * 0.5 +  height * 0.05) )
        context?.addLine(to:CGPoint(x: width * 0.5  , y: height * 0.5 +  height * 0.05) )
        
        context?.move(to:CGPoint(x: width * 0.38 + (height * 0.1) , y: height * 0.7  ) )
                 context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) + height * 0.05, y: height * 0.7) )
              context?.addLine(to:CGPoint(x: width * 0.39 + (height * 0.15) + height * 0.05 , y: height * 0.5 +  height * 0.1) )
        context?.addLine(to:CGPoint(x: width * 0.5 , y: height * 0.5 +  height * 0.1) )
        
        
        
         //FROM ROTATE TO CAM
        context?.move(to:CGPoint(x: width * 0.38  , y: height * 0.65 ) )
        context?.addLine(to:CGPoint(x: width * 0.38, y: height * 0.4) )
        context?.move(to:CGPoint(x: width * 0.38 + (height * 0.02)   , y: height * 0.65 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 + (height * 0.02) , y: height * 0.4) )
        context?.move(to:CGPoint(x: width * 0.38 - (height * 0.02)  , y: height * 0.65 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.02), y: height * 0.4) )
        
        //FROM CAM  TO ROTATE
        context?.move(to:CGPoint(x: width * 0.38 - (height * 0.1) , y: height * 0.25 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.3) , y: height * 0.25 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.3) , y: height * 0.75 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.3) , y: height * 0.75 ) )
         context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.1) , y: height * 0.75 ) )
        
        context?.move(to:CGPoint(x: width * 0.38 - (height * 0.1) , y: height * 0.3 ) )
         context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.25) , y: height * 0.3 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.25) , y: height * 0.7 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.25) , y: height * 0.7 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.1) , y: height * 0.7 ) )
        
         context?.move(to:CGPoint(x: width * 0.38 - (height * 0.1) , y: height * 0.35 ) )
         context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.2) , y: height * 0.35 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.2) , y: height * 0.65 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.2) , y: height * 0.65 ) )
        context?.addLine(to:CGPoint(x: width * 0.38 - (height * 0.1) , y: height * 0.65 ) )
        
        
        
         //FROM REC TO FOLDER
        context?.move(to:CGPoint(x: width * 0.5 , y: height * 0.5 ) )
        context?.addLine(to:CGPoint(x: width * 0.6 , y: height * 0.5) )
        context?.move(to:CGPoint(x: width * 0.5 , y: height * 0.55 ) )
        context?.addLine(to:CGPoint(x: width * 0.6 , y: height * 0.55) )
        context?.move(to:CGPoint(x: width * 0.5 , y: height * 0.45 ) )
        context?.addLine(to:CGPoint(x: width * 0.6 , y: height * 0.45) )
        context?.move(to:CGPoint(x: width * 0.5 , y: height * 0.4 ) )
        context?.addLine(to:CGPoint(x: width * 0.6 , y: height * 0.4) )
        context?.move(to:CGPoint(x: width * 0.5 , y: height * 0.6 ) )
        context?.addLine(to:CGPoint(x: width * 0.6 , y: height * 0.6) )
        
        
        //FROM SLIDER TO SLIDER
        context?.move(to:CGPoint(x:  width*0.015 , y: height * 0.76) )
        context?.addLine(to:CGPoint(x:  width*0.015 - width*0.005 , y: height * 0.76) )
        context?.addLine(to:CGPoint(x:  width*0.015 - width*0.005 , y: height * 0.23) )
        context?.addLine(to:CGPoint(x:  width*0.015 , y: height * 0.23) )
        
        //UPPER LINE
        context?.move(to:CGPoint(x:  0 , y: 0) )
        context?.addLine(to:CGPoint(x:  width, y: 0) )
        
        //FROM FILTERS UP
        for i in 0...4{
            context?.move(to:CGPoint(x:  width*0.75 + CGFloat(i)*height*0.05, y: height*0.3 - CGFloat(i)*height*0.01) )
        context?.addLine(to:CGPoint(x:   width*0.75 + CGFloat(i)*height*0.05, y: CGFloat(i)*height*0.05) )
            context?.addLine(to:CGPoint(x:   width, y: CGFloat(i)*height*0.05) )
        
        }
        
        
        //FROM FILTERS DOWN RIGHT
        for i in 0...75{
                   context?.move(to:CGPoint(x:  width*0.75 + CGFloat(i)*height*0.05, y: height*0.75) )
               context?.addLine(to:CGPoint(x:   width*0.75 + CGFloat(i)*height*0.05, y: height - 10) )
                  
               
               }
        //Buttom
        for j in 0...5{
            context?.move(to:CGPoint(x:  0, y: height - height*0.1 + CGFloat(j)*height*0.025) )
        context?.addLine(to:CGPoint(x:   width, y: height - height*0.1 + CGFloat(j)*height*0.025) )
        }
        
        
        
        context?.strokePath()
        var imageColss = UIImage()
          imageColss = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: .zero)
        UIGraphicsEndImageContext()
        
        // colss(drRect).resizableImage(withCapInsets: .zero)
            let imageView = UIImageView(image: imageColss)
                 self.addSubview(imageView)
                     
          
        }

    func setPhBackImg() {
        let width = self.frame.width
         let height = self.frame.height
         let lineWidth = self.frame.height * 0.005
        let bPoint  = CGPoint(x: self.frame.width*0.15, y:0 )
        let cPoint = CGPoint(x: width*0.15, y: height )
        let ccPoint = CGPoint(x: 0, y: 0)
         UIGraphicsBeginImageContext(self.frame.size)
         let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.black.withAlphaComponent(0.8).cgColor)
         
    
        
          context?.setLineWidth(lineWidth)
        // context?.setLineCap(.round)
       
               
        context?.move(to: CGPoint(x: width, y: height))
        context?.addLine(to:CGPoint(x: 0  , y: height) )
        //context?.addLine(to: bPoint)
          context?.addCurve(to: bPoint , control1: cPoint, control2: ccPoint)
        context?.addLine(to: CGPoint(x: width*0.85, y: 0))
        context?.addCurve(to: CGPoint(x: width, y: height), control1: CGPoint(x: width, y:  0), control2: CGPoint(x: width*0.85, y: height))
   context?.fillPath()
   var imageColss = UIImage()
     imageColss = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: .zero)
   UIGraphicsEndImageContext()
   
   
       let imageView = UIImageView(image: imageColss)
            self.addSubview(imageView)

    
    }
    
    
    
    
    
}
