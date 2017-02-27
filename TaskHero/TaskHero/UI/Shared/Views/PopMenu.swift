import UIKit

class PopMenu: BasePopoverAlert {
    
    dynamic lazy var popupView: DataPickerView = {
        let pick = DataPickerView()
        return pick
    }()
    
    func showPopView(viewController: UIViewController, pick: UIPickerView?) {
        super.showPopView(viewController: viewController)
        
        popupView.frame =  CGRect(x: Constants.Dimension.screenWidth * PopMenuConstants.frameOriginXMultiplier,
                                  y: Constants.Dimension.screenHeight * PopMenuConstants.frameOriginYMultiplier,
                                  width: Constants.Dimension.screenWidth * PopMenuConstants.frameWidthMultiplier,
                                  height: Constants.Dimension.screenHeight * PopMenuConstants.frameHeightMultiplier)
        
        popupView.center = CGPoint(x: PopMenuConstants.screenMidX,
                                   y: PopMenuConstants.screenMidY * PopMenuConstants.popViewCenterYMultiplier)
        popupView.picker = pick!
        
        popupView.picker.dataSource = viewController as! AddTaskViewController
        popupView.picker.delegate = viewController as! AddTaskViewController
        popupView.picker.showsSelectionIndicator = true
        
        viewController.view.addSubview(popupView)
        viewController.view.bringSubview(toFront: popupView)
    }
}
