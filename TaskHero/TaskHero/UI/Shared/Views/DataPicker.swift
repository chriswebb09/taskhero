//
//  DataPicker.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/26/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class DataPickerView: UIView {
    
    // ====================
    // MARK: - Properties
    // ====================
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = Constants.Font.bolderFontMediumLarge
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "When would you like to complete your task?"
        return label
    }()
    
    lazy var button: UIButton = {
        let button = ButtonType.system(title: "Done", color: UIColor.black).newButton
        return button
    }()
    
    lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
}

extension DataPickerView {
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        setupConstraints()
    }
}

extension DataPickerView {

    // MARK: - Configure
    
    fileprivate func setupConstraints() {
        addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        picker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        picker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.22).isActive = true
        picker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        addSubview(alertLabel)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alertLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        alertLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.98).isActive = true
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    }
}
