/*import UIKit
import AssetsLibrary
class ViewContent: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   // var button = UIButton()
//    func setupBack(){
//         button = UIButton(frame: CGRect(x: 10, y: 0, width: 50, height: 20))
//        button.backgroundColor = .red
//        button.titleLabel?.text = "<"
//
//        //self.view.addSubview(button)
//       }
    @objc fileprivate func play(){
    self.dismiss(animated: true, completion: {});
    self.navigationController?.popViewController(animated: true);
    }
    fileprivate func addButton(){
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(ViewContent.play), for: .touchUpInside)
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        myCollectionView.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(myCollectionView)
        addButton()
        //self.view.addSubview(button)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("item at \(indexPath.section)/\(indexPath.item) tapped")
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
            cell.backgroundColor = UIColor.blue
            
            return cell
    }
    
    
    
    
    
    
    
    
    
    
 
}
import UIKit

class ViewContent: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   // var button = UIButton()
//    func setupBack(){
//         button = UIButton(frame: CGRect(x: 10, y: 0, width: 50, height: 20))
//        button.backgroundColor = .red
//        button.titleLabel?.text = "<"
//
//        //self.view.addSubview(button)
//       }
    @objc fileprivate func play(){
    self.dismiss(animated: true, completion: {});
    self.navigationController?.popViewController(animated: true);
    }
    fileprivate func addButton(){
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(ViewContent.play), for: .touchUpInside)
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        myCollectionView.frame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(myCollectionView)
        addButton()
        //self.view.addSubview(button)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print("item at \(indexPath.section)/\(indexPath.item) tapped")
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
            cell.backgroundColor = UIColor.blue
            
            return cell
    }
 
}*/



import UIKit
import MobileCoreServices
import MediaPlayer
import Photos

class ViewContent: UIViewController {
  var firstAsset: AVAsset?
  var secondAsset: AVAsset?
  var audioAsset: AVAsset?
  var loadingAssetOne = false
  
  
  
  @objc fileprivate func library(){
      loadingAssetOne = true
      VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
  }
  @objc fileprivate func back(){
         self.dismiss(animated: true, completion: {});
         self.navigationController?.popViewController(animated: true);
         }
  
    override func viewDidLoad() {
           super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
          
           addButtonL()
           addButtonB()
           //self.view.addSubview(button)
       }
    
    
    
    
  
  
}

extension ViewContent: UIImagePickerControllerDelegate {

    
   // @objc fileprivate func play(){
    //   self.dismiss(animated: true, completion: {});
   //    self.navigationController?.popViewController(animated: true);
//       }
    
    
    
    //MARK: Button Library
    fileprivate func addButtonL(){
           let button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Library", for: UIControl.State.normal)
           button.setTitleColor(UIColor.white, for: UIControl.State.normal)
           button.addTarget(self, action: #selector(ViewContent.library), for: .touchUpInside)
           self.view.addSubview(button)
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
           button.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
           button.widthAnchor.constraint(equalToConstant: 100).isActive = true
           button.heightAnchor.constraint(equalToConstant: 50).isActive = true
       }
    
    //MARK: Button Back
          fileprivate func addButtonB(){
              let button = UIButton()
              button.translatesAutoresizingMaskIntoConstraints = false
              button.setTitle("Back", for: UIControl.State.normal)
              button.setTitleColor(UIColor.white, for: UIControl.State.normal)
              button.addTarget(self, action: #selector(ViewContent.back), for: .touchUpInside)
              self.view.addSubview(button)
           button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
              button.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
              button.widthAnchor.constraint(equalToConstant: 100).isActive = true
              button.heightAnchor.constraint(equalToConstant: 50).isActive = true
          }
    
    
    
    
  
}

extension ViewContent: UINavigationControllerDelegate {
  
}

extension ViewContent: MPMediaPickerControllerDelegate {
  
}
