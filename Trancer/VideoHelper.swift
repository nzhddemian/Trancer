//

import UIKit
import MobileCoreServices
import AVFoundation

class VideoHelper {
  
    static func startMediaBrowser(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerController.SourceType) {
    guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
    
    let mediaUI = UIImagePickerController()
    mediaUI.sourceType = sourceType
    mediaUI.mediaTypes =  [kUTTypeMovie as String, kUTTypeImage as String ]
     //   mediaUI.mediaTypes =
       // [UIImagePickerController availableMediaTypesForSourceType:
           // UIImagePickerControllerSourceTypeCamera]
    mediaUI.allowsEditing = true
    mediaUI.delegate = delegate
    delegate.present(mediaUI, animated: true, completion: nil)
  }

  
}
