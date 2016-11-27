//
//  NotificationPopover.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class NotificationPopover: UIView {
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.black
        containerView.layer.opacity = 0.1
        return containerView
    }()
    
    var popView: NotificationView = {
        let popView = NotificationView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = UIColor.white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        return popView
    }()
    
    
    func showPopView(viewController: UIViewController) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        popView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width * 0.8, height:UIScreen.main.bounds.height * 0.35)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 180)
        popView.clipsToBounds = true
        //containerView.addSubview(popView)
        //containerView.bringSubview(toFront: popView)
        viewController.view.addSubview(popView)
        viewController.view.addSubview(containerView)
        viewController.view.bringSubview(toFront: popView)
    }
    
    func hidePopView(viewController:UIViewController){
        viewController.view.sendSubview(toBack: containerView)
    }
}
