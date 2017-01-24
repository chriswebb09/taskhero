//
//  PopMenu.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PopMenu: BasePopoverAlert {
    
    dynamic lazy var poppupView: DataPickerView = {
        let pick = DataPickerView()
        return pick
    }()
}

extension PopMenu {
    
    func showPopView(viewController: UIViewController, pick: UIPickerView?) {
        super.showPopView(viewController: viewController)
        poppupView.frame =  CGRect(x:UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.7, width:UIScreen.main.bounds.width * 0.9, height:UIScreen.main.bounds.height * 0.4)
        poppupView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY * 0.8)
       // poppupView.backgroundColor = UIColor.white
        poppupView.picker = pick!
        poppupView.picker.dataSource = viewController as! AddTaskViewController
        poppupView.picker.delegate = viewController as! AddTaskViewController
        poppupView.picker.showsSelectionIndicator = true
        viewController.view.addSubview(poppupView)
        viewController.view.bringSubview(toFront: poppupView)
    }
}

