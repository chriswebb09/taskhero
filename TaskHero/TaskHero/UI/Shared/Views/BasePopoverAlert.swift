import UIKit

struct BasePopoverConstants {
    static let popViewBorderWidth: CGFloat = 1
    static let popViewCornerRadius: CGFloat = 10
    static let containerViewCenterX: CGFloat = UIScreen.main.bounds.width / 2
    static let containerViewCenterY: CGFloat = UIScreen.main.bounds.height / 2
    static let containerViewOpacity: CGFloat = 0.5
}

class BasePopoverAlert: UIView {
    
    public lazy var containerView: BasePopView = {
        let containerView = BasePopView()
        containerView.backgroundColor = .black
        containerView.layer.opacity = BasePopoverConstants.containerViewOpacity
        return containerView
    }()
    
    public lazy var popView: BasePopView = {
        let popView = NotificationView()
        popView.layer.borderWidth = BasePopoverConstants.popViewBorderWidth
        popView.layer.cornerRadius = BasePopoverConstants.popViewCornerRadius
        popView.backgroundColor = .white
        popView.layer.borderColor = UIColor.black.cgColor
        
        return popView
    }()
    
    public func showPopView(viewController: UIViewController) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: BasePopoverConstants.containerViewCenterX,
                                       y: BasePopoverConstants.containerViewCenterY)
        viewController.view.addSubview(containerView)
        popView.isHidden = false
        containerView.isHidden = false
        containerView.bringSubview(toFront: popView)
        viewController.view.bringSubview(toFront: containerView)
    }
    
    public func hidePopView(viewController:UIViewController) {
        popView.isHidden = true
        containerView.isHidden = true
        viewController.view.sendSubview(toBack: containerView)
    }
    
    public func hide(viewController:UIViewController) {
        hidePopView(viewController: viewController)
    }
    
    
}
