import UIKit

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
}

extension DataPickerView {
    
    // MARK: - Initialization
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        layer.borderWidth = 1
        layer.cornerRadius = 4
        layer.borderColor = UIColor.black.cgColor
        setupConstraints()
    }
}

extension DataPickerView {

    // MARK: - Configure
    
    internal override func setupConstraints() {
        
        addSubview(picker)
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.centerYAnchor.constraint(equalTo: centerYAnchor, constant: bounds.height * -0.08).isActive = true
        picker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        picker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        picker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        
        addSubview(dataAlertLabel)
        
        dataAlertLabel.translatesAutoresizingMaskIntoConstraints = false
        dataAlertLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dataAlertLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dataAlertLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        dataAlertLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.94).isActive = true
        
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bounds.height * -0.14).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    }
}
