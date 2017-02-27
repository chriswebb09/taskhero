import UIKit

class PhotoPickerView: BasePopView {
    
    // MARK: - UI Element
    
    lazy var button: UIButton = {
        let button = ButtonType.system(title: "Change Profile Picture", color: .black)
        return button.newButton
    }()
    
    // MARK: - Configuration
    
    func addButton(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(PhotoPickerViewConstants.centerYOffset)
            make.width.equalTo(self).multipliedBy(Constants.Dimension.width)
            make.height.equalTo(self).multipliedBy(PhotoPickerViewConstants.heightMultiplier)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(button)
        setupConstraints()
        backgroundColor = .white
        addButton(button: button)
    }
}

struct PhotoPickerViewConstants {
    static let centerYOffset: CGFloat = 20
    static let heightMultiplier: CGFloat = 0.15
}
