import UIKit

class EditProfileViewController: UIViewController {
    
    var currentUser: User?
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Prénom"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nom"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mot de passe"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birthdateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date de naissance"
        textField.keyboardType = .numbersAndPunctuation
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enregistrer", for: .normal)
        button.backgroundColor = UIColor(named: "backgroundOrange")
        button.addTarget(EditProfileViewController.self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(birthdateTextField)
        view.addSubview(saveButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            lastNameTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            
            birthdateTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            birthdateTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            birthdateTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: birthdateTextField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Load user data and populate text fields
        if let user = currentUser {
            firstNameTextField.text = user.firstname
            lastNameTextField.text = user.lastname
            passwordTextField.text = user.password
            emailTextField.text = user.email
            birthdateTextField.text = user.birthdate
        }
    }
    
    @objc func saveButtonTapped() {
//        // Update the user with new information and save changes
//        if let user = currentUser {
//            user.firstname = firstNameTextField.text ?? ""
//            user.lastname = lastNameTextField.text ?? ""
//            user.password = passwordTextField.text ?? ""
//            user.email = emailTextField.text ?? ""
//            user.birthdate = birthdateTextField.text ?? ""
//
//            // Save user changes
//            // TODO: Implement the logic to save the user changes to the server or data store
//
//            // Dismiss the view controller
//            navigationController?.popViewController(animated: true)
//        }
    }
}
