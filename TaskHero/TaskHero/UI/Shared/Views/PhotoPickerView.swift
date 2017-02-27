import UIKit

final class PhotoPickerView: BasePopView {
    
    lazy var button: UIButton = {
        let button = ButtonType.system(title: "Change Profile Picture", color: .black)
        return button.newButton
    }()
    
    // MARK: - Configuration
    
    func addButton(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(Constants.Dimension.width)
            make.centerY.equalTo(self).offset(PhotoPickerViewConstants.centerYOffset)
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

