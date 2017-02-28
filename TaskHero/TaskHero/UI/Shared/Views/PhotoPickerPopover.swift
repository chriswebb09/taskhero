import UIKit

final class PhotoPickerPopover: BasePopoverAlert {
    
    var displayed: Bool = false
    
    lazy var searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.textColor = .black
        searchLabel.textAlignment = .center
        searchLabel.text = "Become a Member"
        searchLabel.font = Constants.Font.fontLarge
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
        popView.isOpaque = true
        popView.layer.opacity = 1
        popView.clipsToBounds = true
        popView.layer.borderWidth = 1
        popView.layer.borderColor = UIColor.black.cgColor
    }
    
    func popViewCentered(popView: PhotoPickerView) {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let frameX = screenWidth * PhotoPickerConstants.multiplyX
        let frameY = screenHeight * PhotoPickerConstants.multiplyYFrame
        let frameWidth = screenWidth * PhotoPickerConstants.frameWidth
        let frameHeight = screenHeight * PhotoPickerConstants.frameHeight
        
        photoPopView.frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
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
        
        photoPopView.layer.opacity = displayed == false ? 0 : 1
        containerView.layer.opacity = displayed == false ? 0 : 1
    }
}
