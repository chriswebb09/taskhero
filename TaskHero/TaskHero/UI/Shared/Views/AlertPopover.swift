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
        containerView.backgroundColor = UIColor.clear
        return containerView
    }()
    
    lazy var searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Become a Member"
        searchLabel.font = Constants.Font.fontLarge
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    var popView: UIView = {
        let popView = UIView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = UIColor.white
        var picker = UIPickerView()
        picker.sizeThatFits(CGSize(width: popView.layer.bounds.width, height: popView.layer.bounds.height))
        popView.addSubview(picker)
        // loadingView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:0.8)
        return popView
    }()
    
    
    func showPopView(viewController: UIViewController) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2.5)
        popView.frame = CGRect(x:0, y:0, width:160, height:160)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        popView.clipsToBounds = true
        containerView.addSubview(popView)
        viewController.view.addSubview(containerView)
        
    }
    
    func hidePopView(viewController:UIViewController){
        viewController.view.sendSubview(toBack: containerView)
    }
}
