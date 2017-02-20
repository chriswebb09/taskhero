import UIKit

class BasePopoverAlert: UIView {
    
    public lazy var containerView: BasePopView = {
        let containerView = BasePopView()
        containerView.backgroundColor = .black
        containerView.layer.opacity = 0.5
        return containerView
    }()
    
    public lazy var popView: BasePopView = {
        let popView = NotificationView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = .white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        return popView
    }()
    
    public func showPopView(viewController: UIViewController) {
        containerView.frame = UIScreen.main.bounds
        containerView.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                       y: UIScreen.main.bounds.height/2)
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
