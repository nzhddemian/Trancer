//
//  ViewController.swift
//  Transformation
//
//  Created by Demian on 10/09/2019.
//  Copyright © 2019 Demian. All rights reserved.
//

//
//  ViewController.swift
//  newXcodeChek
//
//  Created by Demian on 23/08/2019.
//  Copyright © 2019 Demian. All rights reserved.
//

import UIKit
import AVFoundation
import Photos




class CamViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    
    var assetWriter: AVAssetWriter?
          var assetWriterPixelBufferInput: AVAssetWriterInputPixelBufferAdaptor?
          var isWriting = false
          var currentSampleTime: CMTime?
          var currentVideoDimensions: CMVideoDimensions?
    
    let session = AVCaptureSession()
    let imageView = UIImageView()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var orientation: AVCaptureVideoOrientation = .portrait
    let context = CIContext()
    let noirFilter = CIFilter(name: "CIColorControls" )
    let filterEdge = CIFilter(name: "CIEdgeWork" )
    let filterLine = CIFilter(name: "CILineOverlay" )
    var scaleFilter = CIFilter(name: "CICrop")
    let filterEdgeInColor = CIFilter(name: "CIEdges" )
    let sharp = CIFilter(name: "CIBumpDistortionLinear")
    let filterN = CIFilter(name: "CIConvolution7X7" )
    let tionBlur = CIFilter(name: "CIDarkenBlendMode" )!
    let oneCurve = CIFilter(name: "CIToneCurve" )
 let roste = CIFilter(name: "CIDisplacementDistortion" )!
    let stripes = CIFilter(name: "CIStripesGenerator" )
   let pixelFi = CIFilter(name: "CIHexagonalPixellate")
    
   
    // let roste = CIFilter(name: "CIDifferenceBlendMode" )!
    var filter = CIFilter()
  
    var filters = [ "glitch","invert", "none", "edge","line" ]
    var filterSwither = String()
   
   
    var randIndex = Int()
    var txtt = [String.SubSequence]()
     var cam = Bool()
    var width: CGFloat{return CGFloat(self.view.frame.width)}
   var height: CGFloat{return CGFloat(self.view.frame.height)}
    let videoDataOutput = AVCaptureVideoDataOutput()
    let audioDataOutput = AVCaptureAudioDataOutput()
   // var width = CGFloat()
  //  var height = CGFloat()
    var hDist = CGFloat()
    let flashLayer = CAShapeLayer()
    let label = UILabel()
    var tapGesture = UITapGestureRecognizer()
    var  timer = Timer()
    override var prefersStatusBarHidden: Bool {
        return true
    }
     var savedInt = 0
    var size = UIScreen.main.bounds
    
 let buttView = Buttons()
        func setupCntrl(){
            buttView.setupBUtt(CGRect(x: 0, y: self.size.height - self.size.height * 0.1, width: self.size.width , height: self.size.height * 0.1))
            // buttView.setupBUtt(CGRect(x: -self.view.frame.width*0.3, y: self.size.height - self.size.height * 0.1, width: self.size.width + self.view.frame.width*0.3, height: self.size.height * 0.1))
           // self.buttView.picker.frame = CGRect(x:     buttView.frame.width -  buttView.frame.width * 0.275 , y: buttView.frame.minY + buttView.frame.height*0.2 , width: 5 + buttView.frame.width * 0.275, height: buttView.frame.height * 0.6)
           // buttView.layer.cornerRadius = 5
            self.view.addSubview(buttView)
            self.view.addSubview(buttView.picker)
            buttView.picker.delegate = self
            buttView.picker.dataSource = self
            buttView.button.addTarget(self, action: #selector(CamViewController.record), for: .touchUpInside)
            buttView.buttonnn.addTarget(self, action: #selector(CamViewController.play), for: .touchUpInside)
            buttView.buttonn.addTarget(self, action: #selector(CamViewController.photo_video_Switch), for: .touchUpInside)
            buttView.buttonnnn.showsTouchWhenHighlighted = true
            buttView.buttonnnn.addTarget(self, action: #selector(CamViewController.rotateCam), for: .touchUpInside)
            buttView.buttonn.setImage(buttView.videoImg, for: .normal)
            
            
          }
    var timeStr = ""
    func labelSetup(){
        
        if (self.currentSampleTime != nil) {timeStr = "\(self.currentSampleTime!)"}else{timeStr = "00:00:00"}
        label.text =  "\(self.getFreeSpace())" + timeStr + " " + (freeSpaceInBytes() as String)  //timeString(time: TimeInterval(seconds))
        label.frame = CGRect(x: self.width*0.05, y: self.height*0.05, width: self.width, height:  self.height*0.1)
        label.font = UIFont(name:"Menlo", size: 20.0)
        label.textColor = .white
        self.view.addSubview(label)
        //label.text = times(.none)
        
    }
    var seconds = 0
    @objc func movv(){
        seconds+=1
        label.text = "\(self.getFreeSpace())" + "\(self.currentSampleTime!)" + " " + (freeSpaceInBytes() as String)//timeStr //timeString(time: TimeInterval( seconds))
    }
    func timeString(time:TimeInterval) -> String {
          let hours = Int(time) / 3600
          let minutes = Int(time) / 100 % 60
          let seconds = Int(time) % 100
              return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
          }
    var vview = UIView()
      ////////////////////////////////////////  ///////////////////////////////////////////////
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
       // print(UIDevice.current.orientation.isLandscape)
        if(UIDevice.current.orientation.isLandscape){
            if(UIDevice.current.orientation == .landscapeLeft){
            imageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
            }else  if(UIDevice.current.orientation == .landscapeRight){
                       imageView.transform = CGAffineTransform(rotationAngle: .pi / 2)
                       }
            imageView.frame = CGRect(x: 0, y: 0, width: height, height: width )
            self.buttView.frame.origin = CGPoint(x:self.size.height/2 - self.size.width*0.5 , y: self.size.width - self.size.height*0.1)
            self.buttView.picker.frame.origin = CGPoint( x:  self.size.height/2 + size.width * 0.225 , y: buttView.frame.minY + buttView.frame.height*0.25)
            
            
            self.vview.frame.origin = CGPoint(x:self.size.height/2 - self.size.width*0.65 , y: self.size.width - self.size.height*0.1)
            
            
        }else if(UIDevice.current.orientation.isPortrait){
            self.buttView.transform = CGAffineTransform.identity
          //  buttView.setupBUtt(CGRect(x: 0, y: self.height - self.height * 0.11, width: self.width, height: self.height * 0.11))
            self.imageView.transform = CGAffineTransform.identity
            imageView.frame.origin = CGPoint(x:0, y: 0)
            buttView.frame.origin = CGPoint(x:0, y: self.size.height*0.9)
            self.vview.transform = CGAffineTransform.identity
            self.vview.frame.origin = CGPoint(x: -self.view.frame.width*0.1, y: self.size.height*0.9)
           // self.buttView.picker.transform = CGAffineTransform.identity
            self.buttView.picker.frame.origin = CGPoint(x:   self.size.width/2 + self.size.width * 0.225 , y: self.size.height - self.size.height*0.075  )
            //imageView.frame = self.view.bounds
           
        }
    }
   
  func isFirstTimeOpening() -> Bool {
    let defaults = UserDefaults.standard
print(defaults.integer(forKey: "hasRun"))
    if(defaults.integer(forKey: "hasRun") == 0) {
        PHPhotoLibrary.shared().performChanges({
                   PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: "trancer")
                   print("Trancer's been created")
               }, completionHandler: { success, error in
                   if !success { print("Error creating album: \(String(describing: error)).") }
               })
               
       
        defaults.set(1, forKey: "hasRun")
        return true
    }
    return false

  }
   
    override func viewDidLoad() {
        super.viewDidLoad()
       if(self.getFreeSpace()<220){
                     // self.finishRec()
                  let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)
                     
                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                     self.present(alert, animated: true)
                      
                     }
      // isFirstTimeOpening()
        
        //
        switch AVCaptureDevice.authorizationStatus(for: .video) {
               case .authorized: // The user has previously granted access to the camera.
                   self.setupDevice()
                  print("Autorized")
               case .notDetermined:
                print("NotYet")// The user has not yet been asked for camera access.
                   AVCaptureDevice.requestAccess(for: .video) { granted in
                       if granted {
                        print("GOTOVO")
                           self.setupDevice()
                       }
                   }
               
               case .denied:
                print("UZHE")// The user has previously denied access.
                   return

               case .restricted:
                print(".........")// The user can't grant access due to restrictions.
                   return
        @unknown default: break
            //
        }
        
        
        
        self.view.backgroundColor = .black
       
     //   imageView.frame.origin = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        // width = self.view.frame.width
       // height = self.view.frame.height
        
        
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(CamViewController.pinchZoom))
        imageView.isUserInteractionEnabled = true
        //imageView.layout
        imageView.addGestureRecognizer(pinchRecognizer)
       imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height )
        self.view.addSubview(imageView)
      //setupCntrl()
       flashLayerSetup()
        labelSetup()
        vview.frame = CGRect(x: -self.view.frame.width*0.15, y: self.size.height - self.size.height * 0.1, width: self.size.width*1.3 , height: self.size.height * 0.1)
        self.view.addSubview(vview)
        vview.setPhBackImg()
        setupCntrl()
         //setUpWriter()
        //cagle
        
    }
   
    
   func flashLayerSetup(){
        let bbrect = self.view.bounds
          let pathBbigRect = UIBezierPath(rect: bbrect)
          flashLayer.path = pathBbigRect.cgPath
          flashLayer.fillRule = CAShapeLayerFillRule.evenOdd
          flashLayer.fillColor = UIColor.black.cgColor
          flashLayer.opacity = 0.0
        view.layer.addSublayer(flashLayer)
    }
    
    
  
       var rec = false
       @objc fileprivate func play(){
                     // print(getFreeSpace())
                 // let vie = ViewContent()
                  //    vie.modalPresentationStyle = .overFullScreen
                 // vie.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                  //       present(vie, animated: true, completion: nil)
                         clearCache()
                     }
       
       
       
       
       
       
       
       
       
       
      
    
    
   
      
    
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////DEVICE
    //////SETUP
     func setupDevice() {
       guard let capDevice = AVCaptureDevice.default(for: .video) else {return}
        guard let input = try? AVCaptureDeviceInput(device: capDevice) else {return}
        session.sessionPreset = .low
        session.addInput(input)
        session.startRunning()
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        session.addOutput(dataOutput)
        
        currentCamera = backCamera
     }
     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func getFrontCamera() -> AVCaptureDevice?{
        session.sessionPreset = AVCaptureSession.Preset.low
           return AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front).devices.first
              }
      func getBackCamera() -> AVCaptureDevice?{
        session.sessionPreset = AVCaptureSession.Preset.low
           return AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices.first
        }
       var usingFrontCamera = false
       func changeCamera(){
           usingFrontCamera = !usingFrontCamera
           do{
               session.removeInput(session.inputs.first!)
              
               if(usingFrontCamera){
               
                   currentCamera = getFrontCamera()
                imageView.transform =  CGAffineTransform(scaleX: -1.0, y: 1.0)
                
               }else{
                   currentCamera = getBackCamera()
              
                    imageView.transform =  CGAffineTransform(scaleX: 1.0, y: 1.0)
               }
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
               session.addInput(captureDeviceInput)
           }catch{
               print(error.localizedDescription)
           }
       }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
    
    
    
    
    ////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM/
    var float = CGFloat(1.1)
     @objc func pinchZoom(sender:UIPinchGestureRecognizer){
            
               if(float > 1.0){
                   float+=(sender.velocity * 0.05)
               }else{
                float = 1.01
            }
               do{
                   try currentCamera?.lockForConfiguration()
                  // currentCamera?.setFocusModeLocked(lensPosition: Float(float), completionHandler: {(time) -> Void in})
                 let zoomFactor:CGFloat = float
                   if(float > 1.0){
                           
                             currentCamera?.videoZoomFactor = zoomFactor
                              }
                  currentCamera?.unlockForConfiguration()
               }catch{
                   print(error)
               }
        sender.scale = 1.0
      print(float)
    }
////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM////////ZOOM///////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       //////DEVICE
       //////SETUP
    
    
    
    
   
    
    ///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT
    @objc func rotateCam() {
        ppulsate()
      changeCamera()
    }
    
    
    func ppulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.2
    pulse.fromValue = 1.0
    pulse.toValue = 0.95
    pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        buttView.button.layer.add(pulse, forKey: nil)
    }
    
    func fflash() {
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.1
        flash.speed = 10
        flash.fromValue = 0.0
    flash.toValue = 1.0
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    
        imageView.layer.add(flash, forKey: nil)
    }
    
    
    
    
    

     ///////screenSHOT
    ///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT
       ///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT///////screenSHOT
    
       
       func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 1.0
        pulse.toValue = 0.95
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        //button.layer.add(pulse, forKey: nil)
        }
        func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 1.0
        flash.fromValue = 1
        flash.toValue = 0.0
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
            flashLayer.add(flash, forKey: nil)
        }
       
       
       var photo = false
   
    @objc func photo_video_Switch() {
        if self.photo == false{
            self.photo = true
            buttView.buttonn.setImage(buttView.photoImg, for: .normal)
            buttView.button.removeTarget(self, action: #selector(CamViewController.record), for: .touchUpInside)
            buttView.button.addTarget(self, action: #selector(CamViewController.shoot), for: .touchUpInside)
            print("Phtpo\(photo)")
            
        }else{
            self.photo = false
            buttView.buttonn.setImage(buttView.videoImg, for: .normal)
            buttView.button.removeTarget(self, action: #selector(CamViewController.shoot), for: .touchUpInside)
            buttView.button.addTarget(self, action: #selector(CamViewController.record), for: .touchUpInside)
            print("Video\(photo)")
        }
    }
        
       @objc func shoot() {
           pulsate()
        
        takeScreenshot()
        print("shoot")
        
         // Screenshot()
        flash()
       // if timer.isValid{timer.invalidate()}else{seconds = 0 ;timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CamViewController.movv), userInfo: nil, repeats: true) }
       }
      
   
    
  
  @objc open func takeScreenshot(){
       if((filterSwither == "edge") || (filterSwither == "line")){
           UIImageWriteToSavedPhotosAlbum(self.filteredImage.imageWithColor(tintColor: .black), self, nil, nil)
           }else{
        UIImageWriteToSavedPhotosAlbum(self.filteredImage, self, nil, nil)
           }
        
    
      }
     /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT /////////////////////////////////SCREENSHOT
     ////////////////
     ////////

    
    
    
    
    
    
    var saveImage = UIImage()
    var cibackImage = CIImage()
    /////////
    ////////FILTERING
    ////////
    var filteredImage = UIImage()
    
    
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
       
connection.videoOrientation = orientation
        
        var fImage = CIImage()
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
      let firstImage = CIImage(cvImageBuffer: pixelBuffer!)
        //let cgImaged = self.context.createCGImage(scaleImage, from: scaleImage.extent)
        // cibackImage = CIImage(cgImage: cgImaged!)
      // DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { // Change `2.0` to the desired number of seconds.
       // self.cibackImage = CIImage(cgImage: cgImaged!)
      // }
    //print("VDS")
     
       
        
        
       
       
        
        noirFilter?.setValue(firstImage, forKey: kCIInputImageKey)
        
        fImage = noirFilter?.outputImage! ?? CIImage()
        var finalImage = CIImage()
        
        
        
        
        
        
        
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        switch filterSwither {
        case "edge":
            
            //noirFilter?.setValue(sliderB.valB, forKey: kCIInputBrightnessKey)
                      noirFilter?.setValue(buttView.sliderA.valA, forKey: "inputContrast")
           
               // let bckgrd = CIFilter(name: "CIConstantColorGenerator")!
                        //bckgrd.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor")
            
                     
        
            filter = filterEdge!
                      filter.setValue(buttView.sliderB.valB*20+1, forKey: "inputRadius")
            filter.setValue(fImage, forKey: kCIInputImageKey)
           // roste.setValue(bckgrd.outputImage! , forKey:  "inputBackgroundImage")
           // roste.setValue(filter.outputImage!, forKey:  kCIInputImageKey)
             finalImage = filter.outputImage!
        case "line":
            let invert = CIFilter(name: "CIColorInvert")
           noirFilter?.setValue(buttView.sliderA.valA * 5, forKey: "inputContrast")
            filter = filterLine!
           filter.setValue(buttView.sliderB.valB/5, forKey: "inputThreshold")
            filter.setValue(fImage, forKey: kCIInputImageKey)
            let ffilter = filter.outputImage!
            invert?.setValue(ffilter, forKey: kCIInputImageKey)
            finalImage = (invert?.outputImage!)! //(invert?.outputImage!)!
            
        case "glitch":
            filter = filterEdgeInColor!
                       //noirFilter?.setValue(fImage, forKey: kCIInputImageKey)
                       // filter = CIFilter(name:"CIHoleDistortion")!
          noirFilter?.setValue(buttView.sliderB.valB, forKey: "inputSaturation")
                                     filter.setValue(fImage, forKey: kCIInputImageKey)
                                     
                       filter.setValue(buttView.sliderB.valB*230, forKey: "inputIntensity")
                         noirFilter?.setValue(filter.outputImage!, forKey: kCIInputImageKey)
                        noirFilter?.setValue(buttView.sliderA.valA*2 , forKey: "inputContrast")
                     //   filter.setValue(self.view.frame.width/2,self.view.frame.height/2, forKey: "inputRadius")
                       finalImage = (noirFilter?.outputImage!)!
        case "none":
          //  noirFilter?.setValue(buttView.sliderB.valB, forKey: kCIInputBrightnessKey)
                noirFilter?.setValue(buttView.sliderA.valA*2 , forKey: "inputContrast")
            filter = filterN!
            
            filter.setValue(fImage, forKey: kCIInputImageKey)
             finalImage = filter.outputImage!
        case "invert":
            
            noirFilter?.setValue(buttView.sliderB.valB*10, forKey: "inputSaturation")
            noirFilter?.setValue((buttView.sliderA.valA )*10 , forKey: "inputContrast")
   // filter = filterEdgeInColor!
    //tionBlur.setValue(scaleImage, forKey:  kCIInputImageKey)
           // roste.setValue(sliderB.valB*10, forKey:  "inputRadius")
       //roste?.setValue([width/2,height/2], forKey:  "inputCenter")
         //tionBlur?.setValue(50, forKey:  "inputRadius")
   // roste.setValue(cibackImage , forKey:  "inputBackgroundImage")
    pixelFi?.setValue(fImage, forKey:  kCIInputImageKey)
       
           // noirFilter?.setValue(roste.outputImage!, forKey: kCIInputImageKey)
    finalImage =  ((pixelFi?.outputImage!)!)
        default:
              filter = filterEdgeInColor!
              //noirFilter?.setValue(fImage, forKey: kCIInputImageKey)
              // filter = CIFilter(name:"CIHoleDistortion")!
 noirFilter?.setValue(buttView.sliderB.valB, forKey: "inputSaturation")
                            filter.setValue(fImage, forKey: kCIInputImageKey)
                            
              filter.setValue(buttView.sliderB.valB*230, forKey: "inputIntensity")
                noirFilter?.setValue(filter.outputImage!, forKey: kCIInputImageKey)
               noirFilter?.setValue(buttView.sliderA.valA*2 , forKey: "inputContrast")
            //   filter.setValue(self.view.frame.width/2,self.view.frame.height/2, forKey: "inputRadius")
              finalImage = (noirFilter?.outputImage!)!
        }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
      //  print("\(PHPhotoLibrary.authorizationStatus())")
        
        
        
        
        
        let cgImage = self.context.createCGImage(finalImage, from: finalImage.extent)
        
        
        DispatchQueue.main.async {
            if (self.filterSwither == "edge") || (self.filterSwither == "line"){
                self.filteredImage = UIImage(cgImage: cgImage!).imageWithColor(tintColor: .white)
            }else{self.filteredImage = UIImage(cgImage: cgImage!)}
          // self.filteredImage.imageWithColor(tintColor: .white)
            
            
            self.imageView.image = self.filteredImage
            
            //print(self.getFreeSpace())
           
           
        }
        if(self.getFreeSpace()<200){
        if isWriting {
                   finishRec()
                   }
        }
       
          
         autoreleasepool {
       
        let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)!
        self.currentVideoDimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
            let filteredBuffer : CVPixelBuffer? = buffer(from: finalImage)

                                  context.render(_:finalImage, to:filteredBuffer!)
   
          //  CMSampleBufferCreateReadyWithImageBuffer(_:_:_:_:_:)
        //let ixelBuffer = CMSampleBufferCreateReadyWithImageBuffer(filteredBuffer! as! CMSampleBuffer, imageBuffer: <#CVImageBuffer#>)
        self.currentSampleTime = CMSampleBufferGetOutputPresentationTimeStamp(sampleBuffer) //filteredBuffer as! CMSampleBuffer)
        if self.isWriting {
        if self.assetWriterPixelBufferInput?.assetWriterInput.isReadyForMoreMediaData == true {
       
                                         //  CVPixelBufferPoolCreatePixelBuffer(nil, self.assetWriterPixelBufferInput!.pixelBufferPool!, &newPixelBuffer)
                                         //  context.render(filter.outputImage!, to: newPixelBuffer  as! CVPixelBuffer)
                                           
                                                
        
                                        
                                          // let ixelBuffer = CMSampleBufferGetImageBuffer(filteredBuffer as! CMSampleBuffer)
                                           
         let success = self.assetWriterPixelBufferInput?.append(filteredBuffer! , withPresentationTime: self.currentSampleTime!)
         //print("Pixel Buffer ")
            CMSampleBufferInvalidate(sampleBuffer);
            //CFRelease(sampleBuffer);
            //sampleBuffer = NULL;
         if success == false {
          print("Pixel Buffer failed")
        }
       }
      }
     }
    

}

    
    
    
    
    
    



    @IBAction func record(_ sender: Any) {
        pulsate()
        // Screenshot()
        flash()
        if timer.isValid{timer.invalidate()}else{seconds = 0 ;timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CamViewController.movv), userInfo: nil, repeats: true) }
        if isWriting {
           finishRec()
            //clearCache()
           //removeAllCachedResponses()
        } else {
            print("start record")
            buttView.buttonn.isEnabled = false
            createWriter()
            assetWriter?.startWriting()
            assetWriter?.startSession(atSourceTime: currentSampleTime!)
            isWriting = true
        }
    }
    
    public func clearCache(){
        
        print("CACHE")
        let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileManager = FileManager.default
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                    }
                    catch let error as NSError {
                        debugPrint("Ooops! Something went wrong: \(error)")
                    }

                }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    func finishRec(){
        print("stop record")
                   session.stopRunning()
                   buttView.button.isEnabled = false
                   
                   self.isWriting = false
                   assetWriterPixelBufferInput = nil
        
                  
                  // saveMovieToCameraRoll()
                   assetWriter?.finishWriting(completionHandler: {[unowned self] () -> Void in
                      
                        
                       DispatchQueue.main.async {
                          // let activity = UIActivityViewController(activityItems: [self.movieURL()], applicationActivities: nil)
                           //self.present(activity, animated: true, completion: nil)
                           self.buttView.button.isEnabled = true
                           self.buttView.buttonn.isEnabled = true
                      
                           
                           }
                     
                       
        
     })
        self.saveMovieToCameraRoll()
        self.session.startRunning()
    }
    
func saveMovieToCameraRoll() {
    savedInt+=1
  // let docsurl = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

      let albumName = "trancer"

      let videoURL = movieURL()

      PHAssetCollection.getAlbum(title: albumName) { (album) in
        
          if let album = album {
            album.save(videoURL: videoURL as URL, completion: { (url, error) in
                  if let url = url {
                      print("Video '\(url) saved to '\(albumName)'")
                  }
                  else {
                      print("Error: \(String(describing: error))")
                  }
              })
          }
      }
    }
    
    
    func exportAsset(asset: AVAsset) {
        let exportPath = NSTemporaryDirectory().appendingFormat("/video.m4v")
        let exportURL = URL(fileURLWithPath: exportPath)

        let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        exporter?.outputURL = exportURL

        exporter?.exportAsynchronously(completionHandler: {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: exportURL)
            }) { saved, error in
                if saved {
                    print("Saved")
                }
            }
        })
    }
    
   /* func saveMovieToCameraRoll() {
           PHPhotoLibrary.shared().performChanges({ () -> Void in

               let createAssetRequest: PHAssetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.movieURL() as URL)!
               createAssetRequest.placeholderForCreatedAsset

               }) { (success, error) -> Void in
                   if success {
                           print("SAVED")
                       //popup alert success
                   }
                   else {
                       print("NOT SAVED")
                      //popup alert unsuccess
                   }
           }
       }*/
    
    
    
    func getFreeSpace() -> CLongLong // return free space in MB
    {
        var totalFreeSpaceInBytes: CLongLong = 0; //total free space in bytes

        do{
            let spaceFree: CLongLong = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemFreeSize] as! CLongLong;
            totalFreeSpaceInBytes = spaceFree;

        }catch let error{ // Catch error that may be thrown by FileManager
            print("Error is ", error);
        }

        let totalBytes: CLongLong = 1 * CLongLong(totalFreeSpaceInBytes);
        let totalMb: CLongLong = totalBytes / (1024 * 1024);

        return totalMb;
    }
    
    
    func freeSpaceInBytes() -> NSString {

        var remainingSpace = NSLocalizedString("Unknown", comment: "The remaining free disk space on this device is unknown.")

        do {
            let dictionary =  try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            let freeSpaceSize = ((dictionary[FileAttributeKey.systemFreeSize] as AnyObject).longLongValue)!
            remainingSpace = ByteCountFormatter.string(fromByteCount: freeSpaceSize, countStyle: ByteCountFormatter.CountStyle.file)
        }
        catch let error {
            NSLog(error.localizedDescription)
        }

        return remainingSpace as NSString

    }
    
    
    
   

    func movieURL() -> NSURL {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
      //  let result = formatter.string(from: date)
        let tempDir = NSTemporaryDirectory()
        let url = NSURL(fileURLWithPath: tempDir).appendingPathComponent("trancer.m4v")
        return url! as NSURL
    }

    func checkForAndDeleteFile() {
        let fm = FileManager.default
        let url = movieURL()
        let exist = fm.fileExists(atPath: url.path!)

        if exist {
            do {
                try fm.removeItem(at: url as URL)
                print("FILE REMOVED")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    func createWriter() {
        self.checkForAndDeleteFile()

        
        do {
            assetWriter = try AVAssetWriter(outputURL: movieURL() as URL, fileType: AVFileType.mp4)
        } catch let error as NSError {
            print(error.localizedDescription)
            return
        }

        guard let outputSettings = [
            AVVideoCodecKey : AVVideoCodecType.h264,
            AVVideoWidthKey : Int(currentVideoDimensions!.width),
            AVVideoHeightKey : Int(currentVideoDimensions!.height)
            ] as [String : Any]? else{return}

        let assetWriterVideoInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: outputSettings )
        assetWriterVideoInput.expectsMediaDataInRealTime = true
       // assetWriterVideoInput.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2.0))

        let sourcePixelBufferAttributesDictionary = [
            String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_32BGRA),
            String(kCVPixelBufferWidthKey) : Int(currentVideoDimensions!.width),
            String(kCVPixelBufferHeightKey) : Int(currentVideoDimensions!.height),
            String(kCVPixelFormatOpenGLESCompatibility) : kCFBooleanTrue!
        ] as [String : Any]

        assetWriterPixelBufferInput = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: assetWriterVideoInput,
                                                                           sourcePixelBufferAttributes: sourcePixelBufferAttributesDictionary)

        if assetWriter!.canAdd(assetWriterVideoInput) {
            assetWriter!.add(assetWriterVideoInput)
        } else {
            print("no way\(assetWriterVideoInput)")
        }
    }
    
    func buffer(from image: CIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.extent.width), Int(image.extent.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)

        guard (status == kCVReturnSuccess) else {
            return nil
        }

        return pixelBuffer
    }
    
    
   
}


extension UIImage {
 func imageWithColor(tintColor: UIColor) -> UIImage {
     UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

     let context = UIGraphicsGetCurrentContext()!
     context.translateBy(x: 0, y: size.height)
     context.scaleBy(x: 1, y: -1)
     context.setBlendMode(.normal)

     let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
     context.clip(to: rect, mask: self.cgImage!)
     tintColor.setFill()
     context.fill(rect)
     let newImage = UIGraphicsGetImageFromCurrentImageContext()!
     UIGraphicsEndImageContext()

     return newImage
 }



}










extension PHAssetCollection {

    private func isCameraRollAlbum() -> Bool
    {
        let query = PHAssetCollection.fetchAssetCollections(with: .smartAlbum,
                                                            subtype: .smartAlbumUserLibrary,
                                                            options: nil)
        let result: PHAssetCollection? = query.firstObject

        return self == result
    }

    func save(videoURL: URL, completion: @escaping (URL?, String?) -> ()) {

        let isCameraRoll = isCameraRollAlbum()

        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()) {

            PHPhotoLibrary.shared().performChanges({
                if let assetRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL) {
                    if isCameraRoll == false, let placeholder = assetRequest.placeholderForCreatedAsset {
                        let albumChangeRequest = PHAssetCollectionChangeRequest(for: self)
                        albumChangeRequest?.addAssets([placeholder] as NSArray)
                    }
                }
            }, completionHandler: { (success, error) in

                if success == false {
                    completion(nil, error?.localizedDescription)
                }
                else {
                    completion(videoURL, nil)
                }

            })
        }
    }
    class func getAlbum(title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {

        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now()) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", title)
            let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

            if let album = collections.firstObject {
                completionHandler(album)
            } else {
                completionHandler(nil)
            }

        }

    }
}
