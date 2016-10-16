//
//  TaskCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol TaskCellCellDelegate: class {
    func profilePictureTapped()
}

class TaskCell: UITableViewCell {
    
    static let cellIdentifier = "TaskCell"
    
    let taskNameLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.font = UIFont(name:Constants.helveticaLight, size: 20)
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        return textView
    }()
    
    let taskDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red:0.26, green:0.26, blue:0.27, alpha:1.0)
        textView.textColor = UIColor.white
        textView.layer.cornerRadius = 3
        textView.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    let taskDueLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.font = UIFont(name: "HelveticaNeue-UltraLight", size: 18)
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    lazy var taskCompletedView: UIImageView = {
        let taskCompletedImageView = UIImageView()
        return taskCompletedImageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contentView.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        
        contentView.addSubview(taskNameLabel)
        
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        taskNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        taskNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:10).isActive = true
        
        
        contentView.addSubview(taskDescriptionLabel)
        
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        taskDescriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.38).isActive = true
        taskDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.92).isActive = true
        taskDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //taskDescriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        taskDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70).isActive = true
        
        contentView.addSubview(taskDueLabel)
        
        taskDueLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDueLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        taskDueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65).isActive = true
        taskDueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        taskDueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 160).isActive = true
        
        contentView.addSubview(taskCompletedView)
        taskCompletedView.translatesAutoresizingMaskIntoConstraints = false
        taskCompletedView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        taskCompletedView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        taskCompletedView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        taskCompletedView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        taskNameLabel.text = ""
        taskDescriptionLabel.text = ""
    }
}
