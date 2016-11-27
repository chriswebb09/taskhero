//
//  PopMenu.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PopMenu: UIView {
    
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
    
    let popView: DataPickerView = {
        let pick = DataPickerView()
        return pick
    }()
    
    func showPopView(viewController: UIViewController, pick: UIPickerView?) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2.5)
        popView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width / 1.05, height:UIScreen.main.bounds.height / 3)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        popView.picker.dataSource = viewController as! AddTaskViewController
        popView.picker.delegate = viewController as! AddTaskViewController
        popView.picker.showsSelectionIndicator = true
        popView.clipsToBounds = true
        containerView.addSubview(popView)
        viewController.view.addSubview(containerView)
    }

    func hidePopView(viewController:UIViewController){
        viewController.view.sendSubview(toBack: containerView)
    }
}
