import UIKit

class AlertPopover: BasePopoverAlert {
    
    open lazy var alertPopView: AlertView = {
        let popView = AlertView()
        popView.layer.cornerRadius = AlertConstants.cornerRadius
        popView.backgroundColor = .white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = AlertConstants.borderWidth
        return popView
    }()
    
    public override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        alertPopView.isHidden = false
        alertPopView.frame = CGRect(x: UIScreen.main.bounds.width * AlertConstants.alartPopViewXY,
                                    y: UIScreen.main.bounds.height * AlertConstants.alartPopViewXY,
                                    width: UIScreen.main.bounds.width * AlertConstants.width,
                                    height: UIScreen.main.bounds.height * AlertConstants.height)
        alertPopView.center = CGPoint(x: UIScreen.main.bounds.midX,
                                      y: UIScreen.main.bounds.midY)
        alertPopView.clipsToBounds = true
        viewController.view.addSubview(alertPopView)
        viewController.view.bringSubview(toFront: containerView)
        viewController.view.bringSubview(toFront: alertPopView)
    }
    
    public override func hidePopView(viewController: UIViewController) {
        alertPopView.isHidden = true
        containerView.isHidden = true
        viewController.view.sendSubview(toBack: alertPopView)
        viewController.view.sendSubview(toBack: containerView)
    }
}

struct AlertConstants {
    static let cornerRadius: CGFloat = 10
    static let borderWidth: CGFloat = 1
    static let alartPopViewXY: CGFloat = 0.5
    static let width: CGFloat = 0.8
    static let height: CGFloat = 0.35
}
