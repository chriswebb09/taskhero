//
//  Constants.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Font {
        static let helveticaThin = "HelveticaNeue-Thin"
        static let helveticaLight = "HelveticaNeue-Light"
        static let headerFont = "AvenirNext-Medium"
        static let font = "AvenirNext-Regular"
    }
    
    struct Tabbar {
        static let tabbarFrameHeight: CGFloat = 0.09
        static let tabbarColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:0.5)
        static let tabbarTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
    }
    
    struct Login {
        static let loginSuccessColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        static let loginFieldHeight = CGFloat(0.07)
        static let loginFieldWidth = CGFloat(0.85)
        static let loginButtonWidth = CGFloat(0.6)
        static let loginButtonColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        static let loginLogoTopSpacing:CGFloat =  0.045
        static let loginElementSpacing:CGFloat =  0.07
        static let loginSignupElementSpacing:CGFloat =  0.035
        //static let loginCenterElementSpacing:CGFloat = 0.08
    }
    
    static let tableViewBackgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
    
    static let tabbarFrameHeight: CGFloat = 0.09
    static let tabbarColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:0.5)
    static let tabbarTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
    static let navbarBarTintColor = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
    
    static let helveticaThin = "HelveticaNeue-Thin"
    static let helveticaLight = "HelveticaNeue-Light"
    
    static let headerFont = "AvenirNext-Medium"
    static let font = "AvenirNext-Regular"
    
    
    
    static let logoImageWidth = CGFloat(0.6)
    static let logoImageHeight = CGFloat(0.06)
    
    static let signupFieldHeight = CGFloat(0.07)
    static let signupFieldWidth = CGFloat(0.94)
    static let signupFieldFont = UIFont(name: "HelveticaNeue-Thin" , size: 16)
    static let signupFieldColor = UIColor.lightGray.cgColor
    
    static let profileHeaderLabelHeight:CGFloat = 0.2
    
    static let barColor = UIColor(red:0.00, green:0.49, blue:0.76, alpha:1.0)
    
    static let loginFieldHeight = CGFloat(0.07)
    static let loginFieldWidth = CGFloat(0.85)
    static let loginButtonWidth = CGFloat(0.6)
    
    
    public func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
