import UIKit

class TextFieldExtension: UITextField {
    
    // Sets textfield input to + 10 inset on origin x value
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10,
                      y: bounds.origin.y,
                      width: bounds.width + 10,
                      height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10,
                      y: bounds.origin.y,
                      width: bounds.width + 10,
                      height: bounds.height)
    }
}

extension TextFieldExtension {
    
    func configureField(field:UITextField) {
        field.font = Constants.signupFieldFont
        field.layer.borderColor = Constants.signupFieldColor
        field.layer.borderWidth = Constants.Border.borderWidth
        field.layer.cornerRadius = 3
    }
    
    func returnTextField(_ placeholder: String) -> TextFieldExtension {
        let returnTextField = TextFieldExtension()
        returnTextField.placeholder = placeholder
        configureField(field: returnTextField)
        returnTextField.keyboardType = .default
        return returnTextField
    }
    
    func emailField(_ placeholder:String) -> TextFieldExtension {
        let confirmEmailField = TextFieldExtension()
        confirmEmailField.placeholder = placeholder
        configureField(field: confirmEmailField)
        confirmEmailField.keyboardType = .emailAddress
        return confirmEmailField
    }
    
    func passwordField() -> TextFieldExtension {
        let passwordField = TextFieldExtension()
        passwordField.placeholder = "Enter password"
        configureField(field: passwordField)
        passwordField.isSecureTextEntry = true
        return passwordField
    }
}



