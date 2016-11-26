//
//  TaskButton.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 11/25/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

//class TaskButton: UIButton {
//    
//    
//}

enum ButtonType {
    
    case login(title:String), system(title:String, color: UIColor)
    
    func setupLoginButton(with title:String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = Constants.Login.loginButtonColor
        button.setAttributedTitle( NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontNormal!]), for: .normal)
        button.layer.cornerRadius = 2
        return button
    }
    
    func setupSystemButton(with title:String, color: UIColor?) -> UIButton {
        let button = UIButton()
        let buttonColor = color ?? UIColor.black
        button.setAttributedTitle( NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: buttonColor, NSFontAttributeName: Constants.Font.fontNormal!]), for: .normal)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        //button.layer.cornerRadius = 2
        return button
    }
    
    var newButton: UIButton {
        switch self {
        case let .login(title):
            return setupLoginButton(with: title)
        
        case let .system(title, color):
            return setupSystemButton(with: title, color: color)
        }
    
    }
    
    
}



struct ButtonTitle {
    let string: String
}


//lazy var loginButton: UIButton = {
//    let button = UIButton(type: .system)
//    button.backgroundColor = Constants.Login.loginButtonColor
//    button.setAttributedTitle( NSAttributedString(string: "Log In", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: Constants.Font.fontNormal!]), for: .normal)
//    button.layer.cornerRadius = 2
//    return button
//}()
