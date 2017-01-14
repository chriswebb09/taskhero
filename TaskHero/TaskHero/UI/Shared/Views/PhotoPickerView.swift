//
//  PhotoPickerView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class PhotoPickerView: BasePopView {
    
    // MARK: - UI Element
    
    lazy var button: UIButton = {
        let button = ButtonType.system(title: "Change Profile Picture", color: UIColor.black)
        return button.newButton
    }()
}

extension PhotoPickerView {
    
    // MARK: - Configuration
    
    func addButton(button:UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier:Constants.Dimension.width).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(button)
        setupConstraints()
        backgroundColor = UIColor.white
        addButton(button: button)
    }
}
