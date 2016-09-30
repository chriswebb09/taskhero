//
//  SplashViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
   // open var pulsing: Bool = false
    
    //let animatedULogoView: AnimatedULogoView = AnimatedULogoView(frame: CGRect(x: 0.0, y: 0.0, width: 90.0, height: 90.0))
    //var tileGridView: TileGridView!
    
    var initialView = InitialView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(initialView)
        initialView.layoutSubviews()
        
        
        initialView.logoLabel.transform = CGAffineTransform(translationX: -300, y: 0)
        
        Animations().springWithDelay(duration: 0.9, delay: 0.45, animations: {
            self.initialView.logoLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    
//    public init(tileViewFileName: String) {
//        
//
//        tileGridView = TileGridView(TileFileName: tileViewFileName)
//        view.addSubview(tileGridView)
//        tileGridView.frame = view.bounds
//        
//        view.addSubview(animatedULogoView)
//        animatedULogoView.layer.position = view.layer.position
//        
//        tileGridView.startAnimating()
//        animatedULogoView.startAnimating()
//    }
}
