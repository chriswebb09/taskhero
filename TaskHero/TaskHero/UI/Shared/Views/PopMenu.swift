//
//  PopMenu.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PopMenu: UIView {
    
    //let pick = UIPickerView()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        return containerView
    }()
    
   // var picker = UIPickerView()
    
    
    lazy var searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Become a Member"
        searchLabel.font = Constants.Font.fontLarge
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
//    let popView: UIView = {
//        let popView = UIView()
//        popView.layer.cornerRadius = 10
//        //popView.backgroundColor = UIColor.green
//       // popView.addSubview(UIPickerView())
//        // loadingView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:0.8)
//        return popView
//    }()
    
    let popView: DataPickerView = {
        let pick = DataPickerView()
        //pick.picker.dataSource
        //pick.backgroundColor = UIColor.lightGray
        return pick
    }()
    
    
    
//    let popView: AlertView = {
//        let popView = AlertView()
//        popView.layer.cornerRadius = 10
//        popView.backgroundColor = UIColor.white
//       // loadingView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:0.8)
//        return popView
//    }()
    
    
    func showPopView(viewController: UIViewController, pick: UIPickerView?) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2.5)
        //popView.backgroundColor = UIColor.blue
        popView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width / 1.05, height:UIScreen.main.bounds.height / 3)
        //picker?.frame = CGRect(x:0, y:0, width:popView.frame.width, height:popView.frame.height)
        //popView.addSubview(picker!)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        
        popView.picker.dataSource = viewController as! AddTaskViewController
        popView.picker.delegate = viewController as! AddTaskViewController
        popView.picker.showsSelectionIndicator = true
        popView.clipsToBounds = true
        //pick?.layer.borderWidth = 1
        //popView.addSubview(pick!)
        //popView.bringSubview(toFront: pick!)
        containerView.addSubview(popView)
        viewController.view.addSubview(containerView)
       
    }

    func hidePopView(viewController:UIViewController){
        viewController.view.sendSubview(toBack: containerView)
    }
}
