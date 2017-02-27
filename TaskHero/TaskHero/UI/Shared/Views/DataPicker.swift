import UIKit
import SnapKit

final class DataPickerView: BasePopView {
    
    dynamic var dataAlertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = Constants.Font.bolderFontMedium
        label.text = "When would you like to complete your task?"
        return label
    }()
    
    var button: UIButton = {
        let button = ButtonType.system(title: "Done", color: .black).newButton
        return button
    }()
    
    var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderWidth = 0
        picker.layer.borderColor = UIColor.clear.cgColor
        return picker
    }()
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = DataPickerConstants.borderWidth
        layer.cornerRadius = DataPickerConstants.borderRadius
        
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
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(DataPickerConstants.pickerWidthMultiplier)
            make.height.equalTo(self).multipliedBy(DataPickerConstants.pickerHeightMultiplier)
            make.centerY.equalTo(self).offset(bounds.height * DataPickerConstants.pickerCenterYOffset)
        }
    }
    
    func addButton(button: UIButton) {
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(DataPickerConstants.buttonWidthMultiplier)
            make.height.equalTo(self).multipliedBy(DataPickerConstants.buttonHeightMultiplier)
            make.bottom.equalTo(self).offset(bounds.height * DataPickerConstants.buttonBottomOffset)
        }
    }
    
    func addAlertLabel(dataAlertlabel: UILabel) {
        
        addSubview(dataAlertLabel)
        dataAlertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dataAlertLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(DataPickerConstants.dataLabelTopOffset)
            make.width.equalTo(self).multipliedBy(DataPickerConstants.dataLabelWidthMultiplier)
            make.height.equalTo(self).multipliedBy(DataPickerConstants.dataLabelHeightMultiplier)
        }
    }
}
