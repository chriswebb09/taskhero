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
    
    func popViewSettings(popView:PhotoPickerView) {
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        popView.clipsToBounds = true
        popView.isOpaque = true
        popView.layer.opacity = 1
    }
    
    func popViewCentered(popView:PhotoPickerView) {
        popView.frame = CGRect(x: UIScreen.main.bounds.width * 0.5,
                               y: UIScreen.main.bounds.height * 0.35,
                               width: UIScreen.main.bounds.width * 0.75,
                               height: UIScreen.main.bounds.height * 0.35)
        popView.center = CGPoint(x: UIScreen.main.bounds.width * 0.5,
                                 y: UIScreen.main.bounds.height * 0.4)
    }
    
    override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        popViewCentered(popView: popView as! PhotoPickerView)
        popViewSettings(popView: popView as! PhotoPickerView)
        viewController.view.addSubview(containerView)
        viewController.view.addSubview(popView)
    }
    
    func hideView(viewController:UIViewController) {
        popView.isHidden = true
        hidePopView(viewController: viewController)
        popView.layer.opacity = 0
        containerView.layer.opacity = 0
    }
}
