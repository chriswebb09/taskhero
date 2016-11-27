//
//  AlertPopover.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AlertPopover: UIView {
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.black
        containerView.layer.opacity = 0.1
        return containerView
    }()
    
    var popView: AlertView = {
        let popView = AlertView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = UIColor.white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        return popView
    }()
    
    
    func showPopView(viewController: UIViewController) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2.5)
        popView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width * 0.9, height:UIScreen.main.bounds.height * 0.40)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 50)
        popView.clipsToBounds = true
        //containerView.addSubview(popView)
        //containerView.bringSubview(toFront: popView)
        viewController.view.addSubview(popView)
        viewController.view.addSubview(containerView)
        viewController.view.bringSubview(toFront: popView)
        
    }
    
//    func setupConstraints() {
//        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
//        //self.cancelButton.heightAnchor.constraint(equalTo: popView.heightAnchor, multiplier: Constants.signupFieldHeight).isActive = true
//        //self.cancelButton.widthAnchor.constraint(equalTo: popView.widthAnchor, multiplier: Constants.loginButtonWidth).isActive = true
//       // self.cancelButton.centerXAnchor.constraint(equalTo: popView.centerXAnchor).isActive = true
//        //self.cancelButton.bottomAnchor.constraint(equalTo: popView.bottomAnchor).isActive = true
//    }

    func hidePopView(viewController:UIViewController){
        viewController.view.sendSubview(toBack: containerView)
    }
}
