//
//  NotificationPopover.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class NotificationPopover: BasePopoverAlert {
    
    var popView: NotificationView = {
        let popView = NotificationView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = UIColor.white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        return popView
    }()
    
    public override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        popView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width * 0.8, height:UIScreen.main.bounds.height * 0.35)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 180)
        popView.clipsToBounds = true
        viewController.view.addSubview(popView)
        popView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: 0).isActive = true
        popView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: 0).isActive = true 
       // containerView.addSubview(popView)
        //containerView.bringSubview(toFront: popView)
    }
}
