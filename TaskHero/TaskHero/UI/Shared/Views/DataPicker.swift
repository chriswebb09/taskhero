import UIKit
import SnapKit

final class DataPickerView: BasePopView {
    
    // MARK: - Properties
    
    dynamic var dataAlertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.Font.bolderFontMedium
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "When would you like to complete your task?"
        return label
    }()
    
    var button: UIButton = {
        let button = ButtonType.system(title: "Done", color: .black).newButton
        return button
    }()
    
    var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderColor = UIColor.clear.cgColor
        picker.layer.borderWidth = 0
        return picker
    }()
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        
        layer.borderWidth = DataPickerConstants.borderWidth
        layer.cornerRadius = DataPickerConstants.borderRadius
        layer.borderColor = UIColor.black.cgColor
        
        setupConstraints()
    }
    
    // MARK: - Configure
    
    internal override func setupConstraints() {
        addPicker(picker: picker)
        addAlertLabel(dataAlertlabel: dataAlertLabel)
        addButton(button: button)
    }
    
    func addPicker(picker: UIPickerView) {
        addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(bounds.height * DataPickerConstants.pickerCenterYOffset)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(DataPickerConstants.pickerHeightMultiplier)
            make.width.equalTo(self).multipliedBy(DataPickerConstants.pickerWidthMultiplier)
        }
    }
    
    func addButton(button: UIButton) {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(bounds.height * DataPickerConstants.buttonBottomOffset)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(DataPickerConstants.buttonHeightMultiplier)
            make.width.equalTo(self).multipliedBy(DataPickerConstants.buttonWidthMultiplier)
        }
    }
    
    func addAlertLabel(dataAlertlabel: UILabel) {
        addSubview(dataAlertLabel)
        dataAlertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dataAlertLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(DataPickerConstants.dataLabelTopOffset)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(DataPickerConstants.dataLabelHeightMultiplier)
            make.width.equalTo(self).multipliedBy(DataPickerConstants.dataLabelWidthMultiplier)
        }
    }
}

struct DataPickerConstants {
    static let dataLabelTopOffset: CGFloat = 10
    static let dataLabelHeightMultiplier: CGFloat = 0.25
    static let dataLabelWidthMultiplier: CGFloat = 0.94
    static let buttonBottomOffset: CGFloat = -0.14
    static let buttonHeightMultiplier: CGFloat = 0.2
    static let buttonWidthMultiplier: CGFloat = 0.7
    static let pickerCenterYOffset: CGFloat = -0.08
    static let pickerHeightMultiplier: CGFloat = 0.2
    static let pickerWidthMultiplier: CGFloat = 0.7
    static let borderRadius: CGFloat = 4
    static let borderWidth: CGFloat = 1
}
