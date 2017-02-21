//
//  SharedProfileMethods.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 2/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class SharedProfileMethods {
    
    func selectImage(picker: UIImagePickerController, viewController: UIViewController) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true, completion: nil)
    }
}
