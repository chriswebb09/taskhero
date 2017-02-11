//
//  PopMenu.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PopMenu: BasePopoverAlert {
    
    dynamic lazy var popupView: DataPickerView = {
        let pick = DataPickerView()
        return pick
    }()
}

extension PopMenu {
    
    func showPopView(viewController: UIViewController, pick: UIPickerView?) {
        super.showPopView(viewController: viewController)
        popupView.frame =  CGRect(x:UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.7, width:UIScreen.main.bounds.width * 0.96, height: UIScreen.main.bounds.height * 0.4)
        popupView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY * 0.8)
       
        popupView.picker = pick!
        popupView.picker.dataSource = viewController as! AddTaskViewController
        popupView.picker.delegate = viewController as! AddTaskViewController
        popupView.picker.showsSelectionIndicator = true
        viewController.view.addSubview(popupView)
        viewController.view.bringSubview(toFront: popupView)
    }
}

