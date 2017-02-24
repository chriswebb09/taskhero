//
//  ImageAPIClient.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import Firebase

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
}


class ImageAPIClient {
    
    
    var image: UIImage?
    
    fileprivate func handleImageSelectedForInfo(_ info: [String: AnyObject]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            uploadToFirebaseStorageUsingImage(selectedImage, completion: { (imageUrl) in
                self.imageUrl(imageUrl, image: selectedImage)
            })
        }
    }
    
    fileprivate func imageUrl(_ imageUrl: String, image: UIImage) {
        let properties: [String: AnyObject] = ["imageUrl": imageUrl as AnyObject, "imageWidth": image.size.width as AnyObject, "imageHeight": image.size.height as AnyObject]
        imageWithProperties(properties)
    }
    
    
    func uploadToFirebaseStorageUsingImage(_ image: UIImage, completion: @escaping (_ imageUrl: String) -> ()) {
        let imageName = UUID().uuidString
        let profilePicRef = FIRStorage.storage().reference().child("profileImages").child(imageName)
        
        if let uploadData = UIImageJPEGRepresentation(image, 0.2) {
            profilePicRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print("Failed to upload image:", error)
                    return
                }
                
                if let imageUrl = metadata?.downloadURL()?.absoluteString {
                    completion(imageUrl)
                }
                
            })
        }
    }
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil { print(error); return }
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
    
    
    fileprivate func imageWithProperties(_ properties: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toId = UserDataStore.sharedInstance.currentUser.uid
        let fromId = FIRAuth.auth()!.currentUser!.uid
        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
        
        var values: [String: AnyObject] = ["toId": toId as AnyObject, "fromId": fromId as AnyObject, "timestamp": timestamp]
        properties.forEach({values[$0] = $1})
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            let userPicRef = FIRDatabase.database().reference().child("profile_pic").child(fromId).child(toId)
            
            let picKey = childRef.key
            userPicRef.updateChildValues([picKey: 1])
            
            let recipientUserMessagesRef = FIRDatabase.database().reference().child("profile-pic").child(toId).child(fromId)
            recipientUserMessagesRef.updateChildValues([picKey: 1])
        }
    }
    
}
