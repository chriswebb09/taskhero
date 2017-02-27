import UIKit

class PhotoPickerPopover: BasePopoverAlert {
    
    // MARK: - UI Elements
    
    lazy var searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = .black
        searchLabel.text = "Become a Member"
        searchLabel.font = Constants.Font.fontLarge
        searchLabel.textAlignment = .center
        return searchLabel
    }()
    
    lazy var photoPopView: PhotoPickerView = {
        let popView = PhotoPickerView()
        popView.layoutSubviews()
        popView.layer.cornerRadius = 10
        return popView
    }()
    
    // MARK: - Behavior methods
    
    func popViewSettings(popView: PhotoPickerView) {
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        popView.clipsToBounds = true
        popView.isOpaque = true
        popView.layer.opacity = 1
    }
    
    func popViewCentered(popView: PhotoPickerView) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        photoPopView.frame = CGRect(x: screenWidth * PhotoPickerConstants.multiplyX,
                                    y: screenHeight * PhotoPickerConstants.multiplyYFrame,
                                    width: screenWidth * PhotoPickerConstants.frameWidth,
                                    height: screenHeight * PhotoPickerConstants.frameHeight)
        
        photoPopView.center = CGPoint(x: screenWidth * PhotoPickerConstants.multiplyX,
                                      y: screenHeight * PhotoPickerConstants.centerY)
    }
    
    override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        popViewCentered(popView: photoPopView)
        popViewSettings(popView: photoPopView)
        viewController.view.addSubview(containerView)
        viewController.view.addSubview(photoPopView)
    }
    
    func hideView(viewController: UIViewController) {
        photoPopView.isHidden = true
        hidePopView(viewController: viewController)
        photoPopView.layer.opacity = 0
        containerView.layer.opacity = 0
    }
}


struct PhotoPickerConstants {
    static let multiplyX: CGFloat = 0.5
    static let multiplyYFrame: CGFloat = 0.35
    static let frameWidth: CGFloat = 0.75
    static let frameHeight: CGFloat = 0.35
    static let centerY: CGFloat = 0.4
}
