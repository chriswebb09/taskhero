//
//  ProfilePictureViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/23/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ProfilePictureViewController: UIViewController {
    
    let profilePicView = ProfilePictureView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profilePicView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
