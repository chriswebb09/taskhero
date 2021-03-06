import UIKit
import SnapKit

final class NotificationPopover: BasePopoverAlert {
    
    lazy var notifyPopView: NotificationView = {
        let popView = NotificationView()
        popView.backgroundColor = .white
        popView.layer.borderColor = UIColor.black.cgColor
        
        popView.layer.cornerRadius = NotificationPopoverConstants.cornerRadius
        popView.layer.borderWidth = NotificationPopoverConstants.borderWidth
        return popView
    }()
    
    override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        let width = Constants.Dimension.screenWidth * NotificationPopoverConstants.widthMultiplier
        let height = Constants.Dimension.screenHeight * NotificationPopoverConstants.heightMultiplier
        
        notifyPopView.frame = CGRect(x: NotificationPopoverConstants.originXY, y: NotificationPopoverConstants.originXY, width: width, height: height)
        notifyPopView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY * NotificationPopoverConstants.centerMidYMultiplier)
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
