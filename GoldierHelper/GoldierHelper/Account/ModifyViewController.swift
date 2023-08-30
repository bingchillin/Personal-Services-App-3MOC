import UIKit

class EditProfileViewController: UIViewController {
    
    var currentUser: User?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Modification de mon profil"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Prénom"
        //label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom"
        //label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date de naissance (AAAA-MM-JJ)"
        //label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        //label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Mot de passe"
        //label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Prénom"
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Nom"
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birthdateTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Date de naissance"
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birthdateDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    let birthdateDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date // Configuration pour afficher seulement la date
        return datePicker
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Mot de passe"
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 15
        textField.keyboardType = .emailAddress
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
        
        // View setup
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubview(titleLabel)
        
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameTextField)
        
        view.addSubview(birthdateLabel)
        view.addSubview(birthdateTextField)
        
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        
        view.addSubview(saveButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            firstNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 5),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            lastNameLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            lastNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 5),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            birthdateLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            birthdateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            birthdateTextField.topAnchor.constraint(equalTo: birthdateLabel.bottomAnchor, constant: 5),
            birthdateTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            birthdateTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            birthdateTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailLabel.topAnchor.constraint(equalTo: birthdateTextField.bottomAnchor, constant: 30),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: firstNameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Configurez le champ de date de naissance
        birthdateTextField.inputView = birthdateDatePicker
        
        // Configurez une toolbar avec un bouton "Done" pour fermer le clavier
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        birthdateTextField.inputAccessoryView = toolbar
        
        if let user = currentUser {
            firstNameTextField.text = user.firstname
            lastNameTextField.text = user.lastname
            emailTextField.text = user.email
            
            // Format the birthdate from the API response
            if let apiBirthdate = birthdateDateFormatter.date(from: user.birthdate) {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                birthdateTextField.text = formatter.string(from: apiBirthdate)
            }
        }

    }
    
    @IBAction func saveButtonTapped() {
//        guard var user = currentUser else {
//            return
//        }
//
//        // Récupérer les nouvelles informations des champs de texte
//        guard let updatedFirstName = firstNameTextField.text,
//              let updatedLastName = lastNameTextField.text,
//              let updatedEmail = emailTextField.text,
//              let updatedPassword = passwordTextField.text,
//              let updatedBirthdate = birthdateTextField.text else {
//            return
//        }
//
//        // Mettre à jour les propriétés de l'utilisateur
//        user.firstname = updatedFirstName
//        user.lastname = updatedLastName
//        user.email = updatedEmail
//        user.password = updatedPassword
//        user.birthdate = updatedBirthdate
//
//        // Convertir l'objet User en JSON
//        let jsonEncoder = JSONEncoder()
//        do {
//            let userData = try jsonEncoder.encode(user)
//            if let jsonString = String(data: userData, encoding: .utf8) {
//                // Appeler la fonction pour mettre à jour les informations de l'utilisateur sur le serveur
//                UserWebService.updateUser(userId: user.id, parameters: jsonString) { error in
//                    if let error = error {
//                        print("Update User Error: \(error)")
//                        // Gérer l'erreur si nécessaire
//                    } else {
//                        // Mise à jour réussie des informations de l'utilisateur
//                        DispatchQueue.main.async {
//                            self.navigationController?.popViewController(animated: true)
//                        }
//                    }
//                }
//            }
//        } catch {
//            print("Encoding Error: \(error)")
//            // Gérer l'erreur d'encodage si nécessaire
//        }
    }


    
    @objc func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        birthdateTextField.text = formatter.string(from: birthdateDatePicker.date)
        self.view.endEditing(true)
    }

}
