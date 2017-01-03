//
//  SplashViewController.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
    
    var loginVC = LoginViewController()
    var initialView: InitView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(initialView)
        initialView.layoutSubviews()
    }
    
    required init?(coder: NSCoder = NSCoder.empty()) {
        self.initialView = InitView()
        super.init(coder: coder)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        UIView.animate(withDuration: 2,
                       delay: 0.06,
                       usingSpringWithDamping: 4,
                       initialSpringVelocity: 1,
                       options: [.beginFromCurrentState, .curveEaseInOut, .autoreverse],
                       animations: {
                        self.initialView.logoImageView.frame.size = CGSize(width: self.initialView.logoImageView.frame.width * 1.1, height: self.initialView.logoImageView.frame.height * 1.1) }, completion: { _ in
                            self.initialView.logoImageView.frame.size = CGSize(width: self.initialView.logoImageView.frame.width, height: self.initialView.logoImageView.frame.height)
        })
        
        UIView.animate(withDuration: 2,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.9,
                       options: [.beginFromCurrentState, .curveEaseOut],animations: {
                        self.navigationController?.navigationBar.isHidden = false
                        self.navigationController?.navigationBar.barTintColor = Constants.Tabbar.tint }, completion: nil)
    }
}

extension NSCoder {
    class func empty() -> NSCoder {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.finishEncoding()
        return NSKeyedUnarchiver(forReadingWith: data as Data)
    }
}

