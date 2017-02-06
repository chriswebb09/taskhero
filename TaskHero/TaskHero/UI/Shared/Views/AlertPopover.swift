//
//  AlertPopover.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AlertPopover: BasePopoverAlert {
    
    open lazy var alertPopView: AlertView = {
        let popView = AlertView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = UIColor.white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        return popView
    }()
}

extension AlertPopover {
    
    public override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        alertPopView.isHidden = false
        alertPopView.frame = CGRect(x:UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5, width:UIScreen.main.bounds.width * 0.8, height:UIScreen.main.bounds.height * 0.35)
        alertPopView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        alertPopView.clipsToBounds = true
        viewController.view.addSubview(alertPopView)
        viewController.view.bringSubview(toFront: containerView)
        
        viewController.view.bringSubview(toFront: alertPopView)
        
    }
    
    public override func hidePopView(viewController: UIViewController) {
        alertPopView.isHidden = true
        containerView.isHidden = true
        viewController.view.sendSubview(toBack: alertPopView)
        viewController.view.sendSubview(toBack: containerView)
    }

}
