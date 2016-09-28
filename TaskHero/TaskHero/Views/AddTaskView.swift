//
//  AddTaskView.swift
//  TaskTiger
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    
    var addTaskBox = UITextView()
    var addTaskButton = UIButton()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = UIScreen.main.bounds
        setupConstraints()
        setupView()
    }
    
    func setupConstraints() {
        addSubview(addTaskBox)
        addTaskBox.translatesAutoresizingMaskIntoConstraints = false
        addTaskBox.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        addTaskBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40).isActive = true
        addTaskBox.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //addTaskBox.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        addTaskBox.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80).isActive = true
        
        addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        addTaskButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true
        //addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addTaskButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 120).isActive = true
    }
    
    func setupView() {
        addTaskBox.layer.borderWidth = 1
        addTaskBox.layer.borderColor = UIColor.black.cgColor
        addTaskBox.layer.cornerRadius = 4
        
        addTaskButton.layer.borderWidth = 1
        addTaskButton.layer.borderColor = UIColor.black.cgColor
        addTaskButton.layer.cornerRadius = 4
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
