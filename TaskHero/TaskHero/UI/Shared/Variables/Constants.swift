//
//  Constants.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/28/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

public struct Constants {
    
    public struct Color {
        public static let mainColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        public static let backgroundColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        public static let buttonColor = UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
        public static let tableViewBackgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
    }
    
    public struct AttributedTextFontNames {
        
    }
    
    public struct Dimension {
        public static let mainWidth:CGFloat = 0.4
        public static let mainOffset:CGFloat = 30
        public static let buttonHeight:CGFloat = 0.07
        public static let cellButtonHeight:CGFloat = 0.03
        public static let saveButtonHeight:CGFloat = 0.05
        // static let buttonHeight = CGFloat(0.009)
        public static let topOffset:CGFloat = 10
        public static let bottomOffset:CGFloat = -10
        public static let settingsOffset:CGFloat = 0.05
        public static let mainHeight:CGFloat = 0.2
        public static let fieldHeight: CGFloat = 0.75
        public static let height: CGFloat = 0.5
        public static let width: CGFloat = 0.85
    }
    
    public struct TaskCellDimension {
        public static let buttonHeight:CGFloat = 0.07
        public static let editImage:CGFloat = 0.03
        public static let mainWidth:CGFloat = 0.4
        public static let mainOffset:CGFloat = 0.1
    }
    
    public struct Border {
        public static let borderWidth:CGFloat = 1
    }
    
    public struct Font {
        public static let fontNormal = UIFont(name: "HelveticaNeue-Light", size: 18)
        public static let fontSmall = UIFont(name: "HelveticaNeue-Light", size: 12)
        public static let fontMedium = UIFont(name: "HelveticaNeue-Light", size: 16)
        public static let fontLarge = UIFont(name: "HelveticaNeue-Thin", size: 22)
        public static let bolderFontSmall = UIFont(name: "HelveticaNeue", size: 12)
        public static let bolderFontMediumSmall = UIFont(name: "HelveticaNeue", size: 14)
        public static let bolderFontMedium = UIFont(name: "HelveticaNeue", size: 16)
        public static let bolderFontMediumLarge = UIFont(name: "HelveticaNeue", size: 20)
        public static let bolderFontLarge = UIFont(name: "HelveticaNeue", size: 22)
        public static let bolderFontNormal = UIFont(name: "HelveticaNeue", size: 18)
    }
    
    public struct Tabbar {
        public static let tint = UIColor(red:0.07, green:0.59, blue:1.00, alpha:1.0)
        public static let tabbarFrameHeight: CGFloat = 0.09
        public static let navbarAttributedText = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:Constants.Font.bolderFontNormal]
    }
    
    public struct NavBar {
        public static let bottomHeight:CGFloat =  1.0
    }
    
    public struct Login {
        public static let loginSuccessColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
       // public static let loginFieldHeight = CGFloat(0.07)
        public static let loginFieldHeight = CGFloat(0.075)
        public static let loginFieldEditColor: UIColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        public static let loginFieldEditBorderColor: CGColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0).cgColor
        public static let loginFieldWidth = CGFloat(0.85)
        public static let loginButtonWidth = CGFloat(0.6)
        public static let loginButtonColor = UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
        public static let loginLogoTopSpacing:CGFloat =  0.045
        public static let loginElementSpacing:CGFloat =  0.07
        public static let loginSignupElementSpacing:CGFloat =  0.035
        public static let dividerHeight: CGFloat = 0.02
        public static let dividerWidth: CGFloat = 0.9
        public static let registerLabelColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
        public static let signupButtonColor = UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
    }
    
    public struct Profile {
        public struct ProfilePicture {
            public static let profilePictureHeight:CGFloat = 0.14
            public static let profilePictureWidth: CGFloat = 0.25
        }
        
        public struct Offset {
            public static let topOffset:CGFloat =  20
            public static let labelTopOffset:CGFloat = 0.04
        }
    }
    
    public struct Alert {
        public struct CancelButton {
            public static let cancelButtonWidth:CGFloat = 0.5
            public static let cancelButtonColor: UIColor = UIColor(red:0.88, green:0.35, blue:0.35, alpha:1.0)
        }
    }
    
    public struct Settings {
        public static let searchFieldButtonRadius: CGFloat = 2
       // public static let rowHeight: CGFloat = 100
        public static let tableViewHeight:CGFloat = 0.75
        public static let dismissedOpacity:Float = 0
        public static let centerYOffset:CGFloat = 0.1
        
        public struct Profile {
            public static let profileSettingsLabelWidth:CGFloat = 0.75
            public static let profileSettingsDataHeight: CGFloat = 0.4
            public static let profileBannerHeight:CGFloat = 400
            public static let profileViewHeightAnchor:CGFloat =  0.25
            public static let profileDataRightOffset: CGFloat = -10
            public static let profileDataLabelWidth: CGFloat = 0.3
            public static let profileDataRadius: CGFloat = 4
        }
        
        public struct FriendsSetting {
            public static let friendsHeaderLabelHeight:CGFloat = 0.85
            public static let friendsHeaderLabelTopOffset:CGFloat = 0.2
        }
        
        public struct Segment {
            public static let segmentSettingsWidth:CGFloat = 0.96
            public static let segmentSettingsTopOffset:CGFloat = 0.01
            public static let segmentBorderRadius:CGFloat = 8
        }
    }
    
    public struct AddTask {
        public static let boxHeight:CGFloat = 0.3
        public static let topAnchorOffset: CGFloat = 0.04
        public static let taskNameField:CGFloat = 30
    }
    
    public struct Logo {
        public static let logoImageWidth = CGFloat(0.6)
        public static let logoImageHeight = CGFloat(0.06)
    }
    
    public struct TaskCell {
        public static let negativeOffset:CGFloat = -20
        public static let mainHeight:CGFloat = 20
        public static let saveButtonWidth:CGFloat = 70
        public static let nameLabelHeight: CGFloat = 0.2
        public static let nameLabelLeftOffset:CGFloat = 10
        public static let dueWidth:CGFloat = 0.65
        public static let dueTopOffset:CGFloat = 60
        
        public struct Description {
            public static let descriptionLabelWidth: CGFloat = 0.96
            public static let descriptionLabelBackgroundColor: UIColor = UIColor(red:0.01, green:0.47, blue:0.74, alpha:1.0)
            public static let descriptionBoxHeight:CGFloat =  0.4
            public static let boxInset: UIEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 0, right: 0)
        }
        
        public struct Shadow {
            public static let shadowOffset = CGSize(width:-0.45, height: 0.2)
            public static let shadowRadius:CGFloat = 1.0
            public static let shadowOpacity:Float = 0.3
            public static let styledShadowOpacity: Float =  0.0
            public static let styledShadowRadius = CGSize(width: 0, height: 0)
            public static let cornerRadius:CGFloat = 2.0
        }
    }
    
    public struct Signup {
        public static let buttonTopOffset:CGFloat = 0.06
        public static let invalidColor: UIColor = UIColor(red:0.02, green:0.83, blue:0.29, alpha:1.0)
        public static let textFieldColor = UIColor(red:0.93, green:0.04, blue:0.04, alpha:1.0)
        public static let animationColor: UIColor = UIColor(red:0.95, green:0.06, blue:0.06, alpha:1.0)
    }
    
    public struct API {
        public struct User {
            public static let username = "Username"
            public static let email = "Email"
            public static let firstName = "FirstName"
            public static let lastName = "LastName"
            public static let level = "Level"
            public static let joinDate = "JoinDate"
            public static let profilePicture = "ProfilePicture"
            public static let tasksCompleted = "TasksCompleted"
            public static let experiencePoints = "ExperiencePoints"
        }
        
        public struct Task {
            public static let taskName = "TaskName"
            public static let taskDescription = "TaskDescription"
            public static let taskCreated = "TaskCreated"
            public static let taskDue = "TaskDue"
            public static let taskCompleted = "TaskCompleted"
        }
    }
    
    public static let signupFieldHeight = CGFloat(0.07)
    public static let signupFieldWidth = CGFloat(0.94)
    public static let signupFieldFont = UIFont(name: "HelveticaNeue-Thin" , size: 18)
    public static let signupFieldColor = UIColor.lightGray.cgColor
    public static let barColor = UIColor(red:0.00, green:0.49, blue:0.76, alpha:1.0)
    
    public static let helveticaThin = "HelveticaNeue-Thin"
    public static let helveticaLight = "HelveticaNeue-Light"
    public static let headerFont = "AvenirNext-Medium"
    public static let font = "AvenirNext-Regular"
}
