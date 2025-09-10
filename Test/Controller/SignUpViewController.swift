//
//  SignUpViewController.swift
//  Test
//
//  Created by Brinit on 08/09/25.
//

import UIKit
import CryptoKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var errorUserName: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var errorMobile: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorPassWord: UILabel!
    
    
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    @IBOutlet weak var errorReEnterPassWord: UILabel!
    
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupDelegates()
        errorLabelUI()
        // Do any additional setup after loading the view.
    }
    
    func errorLabelUI(){
        errorLabel.text = ""
        errorLabel.textColor = .red
        errorUserName.text = ""
        errorUserName.textColor = .red
        errorEmail.text = ""
        errorEmail.textColor = .red
        errorMobile.text = ""
        errorMobile.textColor = .red
        errorPassWord.text = ""
        errorPassWord.textColor = .red
        errorReEnterPassWord.text = ""
        errorReEnterPassWord.textColor = .red
    }
    
    func setupUI() {
        // Name TextField
        nameTextField.placeholder = "SivamSingh"
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderWidth = 0.5
        nameTextField.autocapitalizationType = .words


        // Email TextField
        emailTextField.placeholder = "shivam@gmail.com"
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderWidth = 0.5
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none

        // Mobile TextField
        mobileTextField.placeholder = "9876543210"
        mobileTextField.layer.borderColor = UIColor.gray.cgColor
        mobileTextField.borderStyle = .roundedRect
        mobileTextField.layer.borderWidth = 0.5
        mobileTextField.keyboardType = .phonePad
        
        // Password TextField
        passwordTextField.placeholder = "Pa$$@123"
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.isSecureTextEntry = true

        
        // Re Enter Password TextField
        reEnterPasswordTextField.placeholder = "Pa$$@123"
        reEnterPasswordTextField.layer.borderColor = UIColor.gray.cgColor
        reEnterPasswordTextField.borderStyle = .roundedRect
        reEnterPasswordTextField.layer.borderWidth = 0.5
        reEnterPasswordTextField.isSecureTextEntry = true
        // Signup Button
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.backgroundColor = .systemBlue
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.tintColor = .white
        createAccountButton.layer.cornerRadius = 8
        createAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        [nameTextField, mobileTextField, emailTextField, passwordTextField].forEach { textField in
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    
    private func setupDelegates() {
        [nameTextField, mobileTextField, emailTextField, passwordTextField,reEnterPasswordTextField].forEach { textField in
            textField.delegate = self
        }
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    private func validateFields() -> Bool {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mobile = mobileTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text ?? ""
        
        if name.isEmpty {
            errorUserName.text = "User Name is Needed"
            showError("Full name is required")
            return false
        }else{
            errorUserName.text = ""
        }
        
        if name.count < 3  {
            errorUserName.text = "User Name is NotValid"
            showError("Name must be at least 3 characters long")
            return false
        }else{
            errorUserName.text = ""
        }
        
       
        
        if email.isEmpty {
            errorEmail.text = "Email address is Needed"
            showError("Email address is required")
            return false
        }else{
            errorEmail.text = ""
        }
        
        if !isValidEmail(email) {
            errorEmail.text = "Email address is not Valid"
            showError("Please enter a valid email address")
            return false
        }else{
            errorEmail.text = ""
        }
        
        if mobile.isEmpty {
            errorMobile.text = "Mobile number is Needed"
            showError("Mobile number is required")
            return false
        }else{
            errorMobile.text = ""
        }
        
        if !isValidMobile(mobile) {
            errorMobile.text = "Mobile number is not Valid"
            showError("Please enter a valid mobile number")
            return false
        }else{
            errorMobile.text = ""
        }
        
        if password.isEmpty {
            errorPassWord.text = "Password is Needed"
            showError("Password is required")
            return false
        }else{
            errorPassWord.text = ""
        }
       
        
        if password.count < 8 || password.count > 15 {
            errorPassWord.text = "Password is not Valid"
            showError("Password must be at least 8 and at most 15 characters long")
            return false
        }else{
            errorPassWord.text = ""
        }
        
        if !isValidPassword(password, name: name){
            errorPassWord.text = "Password is not Valid"
            showError("Password is not Valid")
            return false
        }else{
            errorPassWord.text = ""
        }
        
        if reEnterPasswordTextField.text != passwordTextField.text {
            errorReEnterPassWord.text = "Password is not match"
            showError("Password is not match")
            return false
        }else{
            errorPassWord.text = ""
        }
        
        return true
    }
    
    
    
    private func isValidEmail(_ email: String) -> Bool {
        guard email.count >= 8 && email.count <= 25  else { return false }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidMobile(_ mobile: String) -> Bool {
        let mobileRegex = "^(?:\\+91[-\\s]?)?[0]?[6789]\\d{9}$"
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        return mobilePredicate.evaluate(with: mobile)
    }
    
    private func isValidPassword(_ password: String, name: String) -> Bool {
        
        //Ensures the password is at least 8 characters and no more than 15
        //Prevents the password from containing the provided username
        //Requires the first character to be UperCase
        //At least two uppercase letters
        //At least two Number
        //At least one special character
        
        
            guard password.count >= 8 && password.count <= 15 else { return false }
            guard !password.lowercased().contains(name.lowercased()) else { return false }
            guard password.first?.isUppercase == true else { return false }
            
            let uppercaseCount = password.filter { $0.isUppercase }.count >= 1
            let digitCount = password.filter { $0.isNumber }.count >= 2
            let specialCount = password.filter { "!@#$%^&*()_+-=[]|;:'\",./<>?".contains($0) }.count >= 1
            
            return uppercaseCount && digitCount && specialCount
        }
    
    
    
    
    
    
    
    

//MARK: - UIButton Actions
    @IBAction func closeButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passwordInfoTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Password Requirements", message: "\n* Ensures the password is at least 8 characters and no more than 15 \n\n* Prevents the password from containing the provided username \n\n* Requires the first character to be UperCase \n\n* Contains one uppercase letters \n\n* Contains two Number \n\n* Contains one special character", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
   
    //
    //Requires the first character to be UperCase
    //At least two uppercase letters
    //At least two Number
    //At least one special character
    
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        guard validateFields() else { return }
        
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mobile = mobileTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text ?? ""
        
        createUser(name: name, mobile: mobile, email: email, password: password)
    }
    
    
    @objc private func textFieldDidChange() {
        hideError()
    }
    

    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        signUpScrollView.contentInset = contentInsets
        signUpScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        signUpScrollView.contentInset = .zero
        signUpScrollView.scrollIndicatorInsets = .zero
    }
    
    func performSignup(name: String, mobile: String, email: String, password: String) {
        // Encrypt password before saving
        let encryptedPassword = encryptPassword(password)

        // Save user data with encrypted password
        let userData = UserData(name: name, mobile: mobile, email: email, encryptedPassword: encryptedPassword)
        saveUserData(userData)

        print("Signup successful for: \(name)")
    }

    func encryptPassword(_ password: String) -> String {
        // Using SHA256 for password encryption (in production, use bcrypt or similar)
        let inputData = Data(password.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }

    func saveUserData(_ userData: UserData) {
        // Implement secure storage logic here (e.g., Core Data, Keychain)
        print("Saving user data securely...")
    }

    

    
    // MARK: - User Creation
    private func createUser(name: String, mobile: String, email: String, password: String) {
        // Show loading state
        createAccountButton.setTitle("Creating Account...", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.isEnabled = false
        
        // Simulate network request delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.createAccountButton.setTitle("Create Account", for: .normal)
            self?.createAccountButton.isEnabled = true
            
            // Save encrypted password to Keychain
            let success = KeychainService.savePassword(password, for: email)
            
            if success {
                // In a real app, you'd also save user data to your backend/local storage
                self?.showSuccess("Account created successfully!") {
                    self?.navigationController?.popViewController(animated: true)
                }
            } else {
                self?.showError("Failed to create account. Please try again.")
            }
        }
    }


    // MARK: - UI Feedback
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    private func hideError() {
        errorLabel.isHidden = true
    }
    
    
    private func showSuccess(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}




// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            mobileTextField.becomeFirstResponder()
        case mobileTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            if validateFields() {
//                signupButtonTapped()
            }
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}


    


