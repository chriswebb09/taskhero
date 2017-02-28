import UIKit

struct BasePopoverConstants {
    static let popViewBorderWidth: CGFloat = 1
    static let popViewCornerRadius: CGFloat = 10
    static let containerViewCenterX: CGFloat = UIScreen.main.bounds.width / 2
    static let containerViewCenterY: CGFloat = UIScreen.main.bounds.height / 2
    static let containerViewOpacity: Float = 0.5
}

struct NotificationPopoverConstants {
    static let originXY: CGFloat = 0
    static let widthMultiplier: CGFloat = 0.8
    static let heightMultiplier: CGFloat = 0.35
    static let centerMidYMultiplier: CGFloat = 0.7
    static let cornerRadius: CGFloat = 10
    static let borderWidth: CGFloat = 1
}

struct AppScreenConstants {
    static let loginButtonBottonOffset: CGFloat = -0.04
    static let signupButtonTopOffset: CGFloat = 0.04
    static let heightMultiplier: CGFloat = 0.075
    static let logoHeight: CGFloat = 0.06
    static let logoWidth: CGFloat = 0.75
    static let logoCenterYOffset: CGFloat = -0.2
    static let dividerCenterYOffset: CGFloat = 0.09
}

struct ProfileDataCellConstants {
    static let widthMultiplier: CGFloat = 0.3
    static let heightMultiplier: CGFloat = 0.5
    static let dividerHeightMultiplier: CGFloat = 0.01
}

struct AddTaskViewConstants {
    static let topOffset: CGFloat = 0.02
    static let widthMultiplier: CGFloat = 0.85
    static let heightMultiplier: CGFloat = 0.07
    static let nameLabelTopMultiplier: CGFloat = 0.05
    static let descriptionBoxHeightMultiplier:CGFloat = 0.3
    static let addTaskButtonWidthMultiplier: CGFloat = 0.4
    static let addTaskButtonTopOffset: CGFloat = 0.05
    static let taskNameFieldTopMultiplier: CGFloat = 0.04
    static let taskDescriptionBoxHeightMultiplier: CGFloat = 0.2
}

struct LoadingViewConstants {
    static let frameOriginX: CGFloat = 0
    static let frameOriginY: CGFloat = 0
    static let frameWidth: CGFloat = 60
    static let frameHeight: CGFloat = 60
    static let cornerRadius: CGFloat = 10
    static let backgroundColor: UIColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:0.8)
    
    struct ActivityIndicator {
        static let originXY: CGFloat = 0
        static let width: CGFloat = 40
        static let height: CGFloat = 40
        static let containerCenterX: CGFloat = UIScreen.main.bounds.width / 2
        static let containerCenterY: CGFloat = UIScreen.main.bounds.height / 2.5
    }
}

struct DataPickerConstants {
    static let dataLabelTopOffset: CGFloat = 10
    static let dataLabelHeightMultiplier: CGFloat = 0.25
    static let dataLabelWidthMultiplier: CGFloat = 0.94
    static let buttonBottomOffset: CGFloat = -0.14
    static let buttonHeightMultiplier: CGFloat = 0.2
    static let buttonWidthMultiplier: CGFloat = 0.7
    static let pickerCenterYOffset: CGFloat = -0.08
    static let pickerHeightMultiplier: CGFloat = 0.2
    static let pickerWidthMultiplier: CGFloat = 0.7
    static let borderRadius: CGFloat = 4
    static let borderWidth: CGFloat = 1
}

struct PopMenuConstants {
    static let popViewCenterYMultiplier: CGFloat = 0.8
    static let frameOriginXMultiplier: CGFloat = 0.5
    static let frameOriginYMultiplier: CGFloat = 0.7
    static let frameWidthMultiplier: CGFloat = 0.96
    static let frameHeightMultiplier: CGFloat = 0.4
    static let screenMidX: CGFloat = UIScreen.main.bounds.midX
    static let screenMidY: CGFloat = UIScreen.main.bounds.midY
}

struct NotificationConstants {
    static let dataLabelHeightMultiplier: CGFloat = 0.25
    static let doneButtonHeightMultiplier: CGFloat = 0.25
}

struct AlertConstants {
    static let cornerRadius: CGFloat = 10
    static let borderWidth: CGFloat = 1
    static let alartPopViewXY: CGFloat = 0.5
    static let width: CGFloat = 0.8
    static let height: CGFloat = 0.35
}

struct PhotoPickerViewConstants {
    static let centerYOffset: CGFloat = 20
    static let heightMultiplier: CGFloat = 0.15
}

struct PopConstants {
    static let heightMultiplier: CGFloat = 0.25
}

struct PhotoPickerConstants {
    static let multiplyX: CGFloat = 0.5
    static let multiplyYFrame: CGFloat = 0.35
    static let frameWidth: CGFloat = 0.75
    static let frameHeight: CGFloat = 0.35
    static let centerY: CGFloat = 0.4
}

public struct Constants {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    enum Color {
        case mainColor, backgroundColor, buttonColor, tableViewBackgroundColor
        
        var setColor: UIColor {
            switch self {
            case .mainColor:
                return UIColor(red:0.41, green:0.72, blue:0.90, alpha:1.0)
            case .backgroundColor:
                return UIColor(red:0.21, green:0.22, blue:0.24, alpha:1.0)
            case .buttonColor:
                return UIColor(red:0.10, green:0.71, blue:1.00, alpha:1.0)
            case .tableViewBackgroundColor:
                return UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
            }
        }
    }
    
    public struct Dimension {
        static let screenHeight = UIScreen.main.bounds.height
        static let screenWidth = UIScreen.main.bounds.width
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
