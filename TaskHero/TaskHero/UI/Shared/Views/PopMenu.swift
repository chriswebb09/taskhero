//
//  PopMenu.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PopMenu: BasePopoverAlert {
    lazy var popView: DataPickerView = {
        let pick = DataPickerView()
        return pick
    }()
}

extension PopMenu {
    public func showPopView(viewController: UIViewController, pick: UIPickerView?) {
        super.showPopView(viewController: viewController)
        popView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width / 1.05, height:UIScreen.main.bounds.height / 3)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        popView.picker.dataSource = viewController as! AddTaskViewController
        popView.picker.delegate = viewController as! AddTaskViewController
        popView.picker.showsSelectionIndicator = true
        popView.clipsToBounds = true
        viewController.view.addSubview(popView)
    }
}
