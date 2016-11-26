//
//  TaskCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/24/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    static let cellIdentifier = "TaskCell"
    
    let taskNameLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        //textView.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        textView.font = Constants.Font.taskNameFont
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    let taskDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red:0.01, green:0.47, blue:0.74, alpha:1.0)
        textView.textColor = UIColor.white
        textView.layer.cornerRadius = 2
        textView.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let taskDueLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.font = UIFont(name:"HelveticaNeue-Thin", size: 16)
        textView.textAlignment = .left
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
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
        
        contentView.addSubview(taskDueLabel)
        taskDueLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDueLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2).isActive = true
        taskDueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65).isActive = true
        taskDueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        taskDueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive = true
        
        contentView.addSubview(taskDescriptionLabel)
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.38).isActive = true
        taskDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.94).isActive = true
        taskDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 110).isActive = true
        
        contentView.addSubview(taskCompletedView)
        taskCompletedView.translatesAutoresizingMaskIntoConstraints = false
        taskCompletedView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        taskCompletedView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        taskCompletedView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        taskCompletedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
    }
    
    func configureCell(task:Task) {
        taskNameLabel.text = task.taskName
        taskDueLabel.text = "Due date: \(task.taskDue)"
        taskDescriptionLabel.text = task.taskDescription
        if task.taskCompleted {
            taskCompletedView.image = UIImage(named:"checked")
        } else {
            taskCompletedView.image = UIImage(named:"edit")
        }
        layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        contentView.backgroundColor = UIColor.clear
    }
    
    func setupCellView(width: CGFloat, height: CGFloat) {
        let cellView : UIView = UIView(frame: CGRect(x:0, y:1, width:width, height:height))
        cellView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = 2.0
        cellView.layer.shadowOffset = CGSize(width:-0.45, height: 0.2)
        cellView.layer.shadowOpacity = 0.08
        contentView.addSubview(cellView)
        contentView.sendSubview(toBack: cellView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = ""
        taskDescriptionLabel.text = ""
    }
}
