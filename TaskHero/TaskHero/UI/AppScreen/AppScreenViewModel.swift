//
//  AppScreenViewModel.swift
//  TaskHero
//

import UIKit

struct AppScreenViewModel {
    
    var signupButtonColor: UIColor = {
        return Constants.Color.backgroundColor.setColor
    }()
    
    var signupButtonText: String = {
        return "Register Now"
    }()
    
    var viewDividerBackgroundColor: UIColor = {
        return UIColor.lightGray
    }()
}
