//
//  SplashViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
    var initialView = InitialView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(initialView)
        initialView.layoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.initialView.logoLabel.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        UIView.animate(withDuration: 0.5, delay: 0.1,
                       options: [.curveEaseIn], animations: {
                        self.initialView.logoLabel.center.x += self.view.bounds.width
            }, completion: nil)
    }
}
