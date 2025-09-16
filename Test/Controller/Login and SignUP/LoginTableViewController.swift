//
//  ViewController.swift
//  Test
//
//  Created by Brinit on 08/09/25.
//

import UIKit
import Security


class LoginTableViewController: UITableViewController {
    
    //MARK: - Variables
    
    var allEmailsDB = [UserEmails]()
    var usermail: UserEmails?
    
    //MARK: - Outlets
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var mobileEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
//MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        // Do any additional setup after loading the view.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        self.hideKeyboardWhenTappedAround()
        
      
    }
    
//MARK: - Delegates
    
    private func setupDelegates() {
        mobileEmailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
//MARK: - UI StoryBoards
    func setupUI() {
        // Email/Mobile TextField
        mobileEmailTextField.placeholder = "Email or Mobile Number"
        mobileEmailTextField.layer.borderColor = UIColor.systemGray.cgColor
        mobileEmailTextField.borderStyle = .roundedRect
        mobileEmailTextField.layer.borderWidth = 1
        mobileEmailTextField.keyboardType = .emailAddress
        mobileEmailTextField.autocapitalizationType = .none

        // Password TextField
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.systemGray.cgColor
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 1
        passwordTextField.isSecureTextEntry = true

        // Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 8
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Signup Button
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.layer.cornerRadius = 8
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        errorLabel.text = ""
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        mobileEmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    
    @objc private func textFieldDidChange() {
       hideError()
   }
    
    private func hideError() {
        errorLabel.isHidden = true
    }
    
    // MARK: - Validation
    private func validateFields() -> Bool {
        let email = mobileEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text ?? ""
        
        if email.isEmpty {
            showError("Email or mobile number is required")
            return false
        }
        
        if password.isEmpty {
            showError("Password is required")
            return false
        }
        
        if !isValidEmailOrMobile(email) {
            showError("Please enter a valid email address or mobile number")
            return false
        }
        
        return true
    }
    
    
    private func loginButtonTapped() {
        guard validateFields() else { return }
        
        let email = mobileEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text ?? ""
        
        // Here you would typically make a network request to authenticate
        // i'll check against stored keychain data

        authenticateUser(email: email, password: password)
        
        
    }

    
    // MARK: - Authentication
    
    private func isValidEmailOrMobile(_ input: String) -> Bool {
        // Email validation
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        // Mobile validation (assuming 10-digit format)
        let mobileRegex = "^[0-9]{10,}$"
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        
        return emailPredicate.evaluate(with: input) || mobilePredicate.evaluate(with: input)
    }
    
    private func authenticateUser(email: String, password: String) {
        // Show loading state
        loginButton.setTitle("Logging in...", for: .normal)
        loginButton.isEnabled = false
        
        // Simulate network request delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.loginButton.setTitle("Login", for: .normal)
            self?.loginButton.isEnabled = true
            
            // Check stored credentials (in a real app, this would be a server request)
            if self?.verifyStoredCredentials(email: email, password: password) == true {
                self?.showSuccess("Login successful!")
                // Navigate to main app

                
            } else {
                self?.showError("Invalid email or password")
            }
        }
    }
    
    private func verifyStoredCredentials(email: String,password: String) -> Bool {
        
        // Retrieve stored password from Keychain
        if let storedPassword = KeychainService.loadPassword(for: email) {
            // In a real app, you'd use proper password hashing/verification
            return password == storedPassword
            
           
        }
        return false
    }

    
    // MARK: - UI Feedback
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        
        // Add shake animation
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x - 5, y: errorLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x + 5, y: errorLabel.center.y))
        errorLabel.layer.add(animation, forKey: "position")
    }
    

    
    private func showSuccess(_ message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default){_ in
          
            
            if let vc =
                
                self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                    self.getUser()
                    vc.user = self.usermail
                    self.mobileEmailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.navigationController?.pushViewController(vc, animated: true)
            }
        })
        present(alert, animated: true)
    }
    
    func getUser(){
        allEmailsDB = DatabaseHelper.shareInstance.fetchingEmailData()
        
        for gettingEmail in allEmailsDB{
            if gettingEmail.email == mobileEmailTextField.text{
                print("getting core data email is...!! \(mobileEmailTextField.text)")
                
                usermail = gettingEmail
            }
            else {
                print("Error Loggedin User....!!! find From CoreData...!!!")
                return
            }
        }
        
     }


    
}


//MARK: - Actions Buttons
extension LoginTableViewController {
    
    //MARK: - Button Actions
        @IBAction func loginTapped(_ sender: Any) {
            loginButtonTapped()
        }
        
        @IBAction func signUpTapped(_ sender: UIButton) {
            
            guard let vc =  storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return}
            navigationController?.pushViewController(vc, animated: true)

        }
    
}

// MARK: - UITextFieldDelegate
extension LoginTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mobileEmailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            if validateFields() {
                loginButtonTapped()
            }
        }
        return true
    }
}


