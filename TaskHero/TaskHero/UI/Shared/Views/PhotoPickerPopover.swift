//
//  PhotoPickerPopover.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PhotoPickerPopover: BasePopoverAlert {
    
    lazy var searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = UIColor.black
        searchLabel.text = "Become a Member"
        searchLabel.font = Constants.Font.fontLarge
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    lazy var popView: PhotoPickerView = {
        let popView = PhotoPickerView()
        popView.layoutSubviews()
        popView.layer.cornerRadius = 10
        return popView
    }()
    
    public override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        popView.frame = CGRect(x:UIScreen.main.bounds.width * 0.5, y:UIScreen.main.bounds.height * 0.35, width:UIScreen.main.bounds.width * 0.75, height:UIScreen.main.bounds.height * 0.35)
        popView.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y:UIScreen.main.bounds.height * 0.4)
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        popView.clipsToBounds = true
        popView.isOpaque = true
        popView.layer.opacity = 1
        viewController.view.addSubview(containerView)
        viewController.view.addSubview(popView)
    }
    
    func hideView(viewController:UIViewController) {
        popView.isHidden = true
        hidePopView(viewController: viewController)
        popView.layer.opacity = 0
        containerView.layer.opacity = 0
    }
}
