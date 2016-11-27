//
//  PickerPopMenu.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PickerPopMenu: BasePopoverAlert {
    
    lazy var searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Become a Member"
        searchLabel.font = Constants.Font.fontLarge
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    let popView: PhotoPickerView = {
        let popView = PhotoPickerView()
        popView.layoutSubviews()
        popView.layer.cornerRadius = 10
        return popView
    }()
    
    public override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        popView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width * 0.75, height:UIScreen.main.bounds.height * 0.35)
        popView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        popView.clipsToBounds = true
        
        containerView.addSubview(popView)
        viewController.view.addSubview(containerView)
        
    }
}
