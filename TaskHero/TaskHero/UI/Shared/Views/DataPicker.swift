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
        layer.borderWidth = 1
        layer.cornerRadius = 4
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
            make.centerY.equalTo(self).offset(bounds.height * -0.08)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.2)
            make.width.equalTo(self).multipliedBy(0.7)
        }
    }
    
    func addButton(button: UIButton) {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(bounds.height * -0.14)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.2)
            make.width.equalTo(self).multipliedBy(0.7)
        }
    }
    
    func addAlertLabel(dataAlertlabel: UILabel) {
        addSubview(dataAlertLabel)
        dataAlertLabel.translatesAutoresizingMaskIntoConstraints = false
        dataAlertLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(self).multipliedBy(0.94)
        }
    }
}
