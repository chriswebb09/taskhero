import UIKit

class BasePopoverAlert: UIView {
    
    public lazy var containerView: BasePopView = {
        let containerView = BasePopView()
        containerView.backgroundColor = .black
        containerView.layer.opacity = BasePopoverConstants.containerViewOpacity
        return containerView
    }()
    
    public lazy var popView: BasePopView = {
        let popView = NotificationView()
        popView.backgroundColor = .white
        popView.layer.borderColor = UIColor.black.cgColor
        
        popView.layer.borderWidth = BasePopoverConstants.popViewBorderWidth
        popView.layer.cornerRadius = BasePopoverConstants.popViewCornerRadius
        return popView
    }()
    
    public func showPopView(viewController: UIViewController) {
        
        containerView.center = CGPoint(x: BasePopoverConstants.containerViewCenterX, y: BasePopoverConstants.containerViewCenterY)
        containerView.frame = UIScreen.main.bounds
        containerView.isHidden = false
        
        viewController.view.addSubview(containerView)
        popView.isHidden = false
        containerView.bringSubview(toFront: popView)
        viewController.view.bringSubview(toFront: containerView)
    }
    
    public func hidePopView(viewController: UIViewController) {
        popView.isHidden = true
        containerView.isHidden = true
        viewController.view.sendSubview(toBack: containerView)
    }
    
    public func hide(viewController: UIViewController) {
        hidePopView(viewController: viewController)
    }
}
