//
//  TaskHeaderCell.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/23/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol TaskHeaderCellDelegate: class {
    
}

class TaskHeaderCell: UITableViewCell {
    
    let taskListNameLabel: UILabel = {
        let taskListNameLabel = UILabel()
        return taskListNameLabel
    }()
    
    let taskScoreLabel: UILabel = {
        let taskListScoreLabel = UILabel()
        return taskListScoreLabel
    }()
    
    static let cellIdentifier = "TaskHeaderCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupView(view: taskListNameLabel)
        setupView(view: taskScoreLabel)
    }
    
    private func setupView(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
