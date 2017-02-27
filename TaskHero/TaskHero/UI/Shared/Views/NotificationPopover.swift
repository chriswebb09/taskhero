import UIKit
import SnapKit

struct NotificationPopoverConstants {
    static let originXY: CGFloat = 0
    static let widthMultiplier: CGFloat = 0.8
    static let heightMultiplier: CGFloat = 0.35
}

class NotificationPopover: BasePopoverAlert {
    
    lazy var notifyPopView: NotificationView = {
        let popView = NotificationView()
        popView.layer.cornerRadius = 10
        popView.backgroundColor = .white
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.borderWidth = 1
        return popView
    }()
    
    override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        
        notifyPopView.frame = CGRect(x: NotificationPopoverConstants.originXY, y: NotificationPopoverConstants.originXY, width: UIScreen.main.bounds.width * NotificationPopoverConstants.widthMultiplier, height: UIScreen.main.bounds.height * NotificationPopoverConstants.heightMultiplier)
        notifyPopView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY * 0.7)
        notifyPopView.clipsToBounds = true
        
        viewController.view.addSubview(notifyPopView)
        viewController.view.bringSubview(toFront: notifyPopView)
        
        notifyPopView.isHidden = false
        notifyPopView.snp.makeConstraints { make in
            make.centerY.equalTo(viewController.view.snp.centerY)
            make.centerX.equalTo(viewController.view.snp.centerX)
        }
    }
    
    override func hidePopView(viewController: UIViewController) {
        notifyPopView.isHidden = true
        viewController.view.sendSubview(toBack: notifyPopView)
    }
}
