//
//  Constants.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Color {
        static let mainColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        static let backgroundColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        static let buttonColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        static let tableViewBackgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
    }
    
    struct Dimension {
        static let mainWidth:CGFloat = 0.4
        static let mainOffset:CGFloat = 30
        static let buttonHeight:CGFloat = 0.07
        static let cellButtonHeight:CGFloat = 0.04
       // static let buttonHeight = CGFloat(0.009)
        static let topOffset:CGFloat = 10
        static let bottomOffset:CGFloat = -10
        static let settingsOffset:CGFloat = 0.05
        static let mainHeight:CGFloat = 0.2
        static let height: CGFloat = 0.5
        static let width: CGFloat = 0.85
    }
    
    struct Border {
        static let borderWidth:CGFloat = 1
    }
    
    struct Font {
        static let fontNormal = UIFont(name: "HelveticaNeue-Light", size: 18)
        static let fontSmall = UIFont(name: "HelveticaNeue-Light", size: 12)
        static let fontMedium = UIFont(name: "HelveticaNeue-Light", size: 16)
        static let fontLarge = UIFont(name: "HelveticaNeue-Thin", size: 22)
        static let bolderFontSmall = UIFont(name: "HelveticaNeue", size: 12)
        static let bolderFontMedium = UIFont(name: "HelveticaNeue", size: 16)
        static let bolderFontLarge = UIFont(name: "HelveticaNeue", size: 22)
        static let bolderFontNormal = UIFont(name: "HelveticaNeue", size: 18)
    }

    struct Tabbar {
        static let tint = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        static let tabbarFrameHeight: CGFloat = 0.09
        static let navbarAttributedText = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:Constants.Font.bolderFontNormal]
    }
    
    struct NavBar {
        static let bottomHeight:CGFloat =  1.0
        
    }
    
    struct Login {
        static let loginSuccessColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        static let loginFieldHeight = CGFloat(0.07)
        static let loginFieldEditColor: UIColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        static let loginFieldEditBorderColor: CGColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0).cgColor
        static let loginFieldWidth = CGFloat(0.85)
        static let loginButtonWidth = CGFloat(0.6)
        static let loginButtonColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        static let loginLogoTopSpacing:CGFloat =  0.045
        static let loginElementSpacing:CGFloat =  0.07
        static let loginSignupElementSpacing:CGFloat =  0.035
        static let dividerHeight: CGFloat = 0.02
        static let dividerWidth: CGFloat = 0.9
        static let registerLabelColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        static let signupButtonColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
    }
    
    struct Profile {
        struct ProfilePicture {
            static let profilePictureHeight:CGFloat = 0.14
            static let profilePictureWidth: CGFloat = 0.25
        }
        
        struct Offset {
            static let topOffset:CGFloat =  20
            static let labelTopOffset:CGFloat = 0.04
        }
    }
    
    struct Alert {
        struct CancelButton {
            static let cancelButtonWidth:CGFloat = 0.5
            static let cancelButtonColor: UIColor = UIColor(red:0.88, green:0.35, blue:0.35, alpha:1.0)
        }
    }
    
    struct Settings {
        static let searchFieldButtonRadius: CGFloat = 2
        static let rowHeight: CGFloat = 100
        static let tableViewHeight:CGFloat = 0.75
        static let dismissedOpacity:Float = 0
        static let centerYOffset:CGFloat = 0.1
        
        struct Profile {
            static let profileSettingsLabelWidth:CGFloat = 0.75
            static let profileSettingsDataHeight: CGFloat = 0.4
            static let profileBannerHeight:CGFloat = 400
            static let profileViewHeightAnchor:CGFloat =  0.25
            static let profileDataRightOffset: CGFloat = -10
            static let profileDataLabelWidth: CGFloat = 0.3
            static let profileDataRadius: CGFloat = 4
        }
        
        struct FriendsSetting {
            static let friendsHeaderLabelHeight:CGFloat = 0.85
            static let friendsHeaderLabelTopOffset:CGFloat = 0.2
        }
        
        struct Segment {
            static let segmentSettingsWidth:CGFloat = 0.96
            static let segmentSettingsTopOffset:CGFloat = 0.01
            static let segmentBorderRadius:CGFloat = 8
        }
    }
    
    struct AddTask {
        static let boxHeight:CGFloat = 0.3
        static let topAnchorOffset: CGFloat = 0.04
        static let taskNameField:CGFloat = 30
    }
    
    struct Logo {
        static let logoImageWidth = CGFloat(0.6)
        static let logoImageHeight = CGFloat(0.06)
    }
    
    struct TaskCell {
        static let negativeOffset:CGFloat = -20
        static let mainHeight:CGFloat = 20
        static let saveButtonWidth:CGFloat = 70
        static let nameLabelHeight: CGFloat = 0.2
        static let nameLabelLeftOffset:CGFloat = 10
        static let dueWidth:CGFloat = 0.65
        static let dueTopOffset:CGFloat = 60
        
        struct Description {
            static let descriptionLabelWidth: CGFloat = 0.94
            static let descriptionLabelBackgroundColor: UIColor = UIColor(red:0.01, green:0.47, blue:0.74, alpha:1.0)
            static let descriptionBoxHeight:CGFloat =  0.38
            static let boxInset: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 0)
        }
        
        struct Shadow {
            static let shadowOffset = CGSize(width:-0.45, height: 0.2)
            static let shadowRadius:CGFloat = 1.0
            static let shadowOpacity:Float = 0.3
            static let styledShadowOpacity: Float =  0.0
            static let styledShadowRadius = CGSize(width: 0, height: 0)
            static let cornerRadius:CGFloat = 2.0
        }
    }
    
    struct Signup {
        static let buttonTopOffset:CGFloat = 0.06
        static let invalidColor: UIColor = UIColor(red:0.02, green:0.83, blue:0.29, alpha:1.0)
        static let textFieldColor = UIColor(red:0.93, green:0.04, blue:0.04, alpha:1.0)
        static let animationColor: UIColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0)
    }
    
    struct API {
        struct User {
            static let username = "Username"
            static let email = "Email"
            static let firstName = "FirstName"
            static let lastName = "LastName"
            static let level = "Level"
            static let joinDate = "JoinDate"
            static let profilePicture = "ProfilePicture"
            static let tasksCompleted = "TasksCompleted"
            static let experiencePoints = "ExperiencePoints"
        }
        
        struct Task {
            static let taskName = "TaskName"
            static let taskDescription = "TaskDescription"
            static let taskCreated = "TaskCreated"
            static let taskDue = "TaskDue"
            static let taskCompleted = "TaskCompleted"
        }
    }
    
    static let signupFieldHeight = CGFloat(0.07)
    static let signupFieldWidth = CGFloat(0.94)
    static let signupFieldFont = UIFont(name: "HelveticaNeue-Thin" , size: 16)
    static let signupFieldColor = UIColor.lightGray.cgColor
    static let barColor = UIColor(red:0.00, green:0.49, blue:0.76, alpha:1.0)
    public func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    static let helveticaThin = "HelveticaNeue-Thin"
    static let helveticaLight = "HelveticaNeue-Light"
    static let headerFont = "AvenirNext-Medium"
    static let font = "AvenirNext-Regular"
}
