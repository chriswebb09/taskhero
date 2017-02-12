import UIKit

extension UINavigationBar {
    
    // Setup gray underline UINavigationBar
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}



extension UINavigationController {
    
    func setupNav() {
        navigationBar.isHidden = false
        navigationBar.setBottomBorderColor(color: .lightGray, height: Constants.Border.borderWidth)
    }
}
