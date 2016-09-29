//
//  ProfilePicViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

class ProfilePictureViewController: UIViewController {
    
    let profilePictureView = ProfilePictureView()
    
    var databaseRef: FIRDatabaseReference!
    let uid = FIRAuth.auth()!.currentUser!.uid

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profilePictureView)
        profilePictureView.layoutSubviews()
        self.databaseRef = FIRDatabase.database().reference(withPath:"users/\(uid)/")
        navigationController?.navigationBar.isHidden = false
//        let backButton = UIBarButtonItem(image:UIImage(named:"back-1"), style: .done, target:self, action: #selector(backTapped))
//        
//        backButton.title = "Back"
//        backButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 18)!], for: .normal)
//        backButton.tintColor = UIColor.black
        
        
//        let barButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
//        
//        barButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.font, size: 20)!], for: .normal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 18)!], for: .normal)
       // navigationControlle

        //profilePictureView.profilePicture.image = store.currentUser?.profilePicture!
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonTapped() {
        navigationController?.popToRootViewController(animated: false)
    }
    
 //   func backTapped(sender: UIBarButtonItem) {
       // navigationController?.navigationBar.backItem?.backBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 18)!], for: .normal)
            //.setTitleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: Constants.helveticaThin, size: 18)!]
       // navigationController?.popToRootViewController(animated: false)
//}
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profilePictureView.profilePicture.image = image
        self.dismiss(animated: true, completion: nil)
        var data = NSData()
        data = UIImageJPEGRepresentation(profilePictureView.profilePicture.image!, 0.8)! as NSData
        // set upload path
        //let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("userPhoto")"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        self.databaseRef.child("profilePicture").setValue(data)
        //putData(data, metadata: metaData){(metaData,error) in
            //if let error = error {
            //    print(error.localizedDescription)
           //     return
          //  } else {
                //store downloadURL
          //      let downloadURL = metaData.downloadURL()!.absoluteString
                //store downloadURL at database
           //     self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["profilePicture": downloadURL])
          //  }
            
       // }
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
