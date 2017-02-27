import UIKit

class PopMenu: BasePopoverAlert {

    
    dynamic lazy var popupView: DataPickerView = {
        let pick = DataPickerView()
        return pick
    }()
    
    func showPopView(viewController: UIViewController, pick: UIPickerView?) {
        super.showPopView(viewController: viewController)
        
        popupView.frame =  CGRect(x: Constants.Dimension.screenWidth * 0.5,
                                  y: Constants.Dimension.screenHeight * 0.7,
                                  width: Constants.Dimension.screenWidth * 0.96,
                                  height: Constants.Dimension.screenHeight * 0.4)
        
        popupView.center = CGPoint(x: UIScreen.main.bounds.midX,
                                   y: UIScreen.main.bounds.midY * 0.8)
        popupView.picker = pick!
        popupView.picker.dataSource = viewController as! AddTaskViewController
        popupView.picker.delegate = viewController as! AddTaskViewController
        popupView.picker.showsSelectionIndicator = true
        viewController.view.addSubview(popupView)
        viewController.view.bringSubview(toFront: popupView)
    }
}

