//
//  NotificationPopover.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/27/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class NotificationPopover: BasePopoverAlert {
    
    lazy var notifyPopView: NotificationView = {
        let popView = NotificationView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = UIColor.white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        return popView
    }()
}

extension NotificationPopover {
    
    override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        notifyPopView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width * 0.8, height:UIScreen.main.bounds.height * 0.35)
        notifyPopView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY * 0.7)
        notifyPopView.clipsToBounds = true
        viewController.view.addSubview(notifyPopView)
        viewController.view.bringSubview(toFront: notifyPopView)
        notifyPopView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: 0).isActive = true
        notifyPopView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: 0).isActive = true
    }
    
    override func hidePopView(viewController: UIViewController) {
        notifyPopView.isHidden = true
        notifyPopView.sendSubview(toBack: viewController.view)
    }
}
