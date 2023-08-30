import UIKit

class AccountViewController: UIViewController {
    
    var currentUser: User?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mon profil"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userInfoView: CardView = {
        let view = CardView()
        view.backgroundColor = UIColor(named: "backgroundBlue")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "Modifier votre profil"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Modifier vos informations utilisateur"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Se déconnecter"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let professionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editProfileView: CardView = {
        let view = CardView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoutView: CardView = {
        let view = CardView()
        view.backgroundColor = UIColor(named: "backgroundOrange")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Profile")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let logoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogOut")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfileViewTapped))
        editProfileView.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubview(titleLabel)
        
        view.addSubview(userInfoView)
        userInfoView.addSubview(nameLabel)
        userInfoView.addSubview(professionLabel)
        userInfoView.addSubview(emailLabel)
        
        view.addSubview(editProfileView)
        editProfileView.addSubview(editProfileLabel)
        editProfileView.addSubview(descriptionLabel)
        editProfileView.addSubview(profileImageView)
        
        view.addSubview(logoutView)
        logoutView.addSubview(logoutLabel)
        logoutView.addSubview(logoutImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            userInfoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            userInfoView.heightAnchor.constraint(equalToConstant: 250),
            
            nameLabel.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 30),
            
            professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            professionLabel.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 30),
            
            emailLabel.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: -30),
            emailLabel.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 30),
            
            editProfileView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 30),
            editProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            editProfileView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            editProfileView.heightAnchor.constraint(equalToConstant: 250),
            
            editProfileLabel.topAnchor.constraint(equalTo: editProfileView.topAnchor, constant: 30),
            editProfileLabel.leadingAnchor.constraint(equalTo: editProfileView.leadingAnchor, constant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: editProfileLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: editProfileView.leadingAnchor, constant: 30),
            
            profileImageView.bottomAnchor.constraint(equalTo: editProfileView.bottomAnchor, constant: -20),
            profileImageView.trailingAnchor.constraint(equalTo: editProfileView.trailingAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            logoutView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 30),
            logoutView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            logoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            logoutView.heightAnchor.constraint(equalToConstant: 250),
            
            logoutLabel.topAnchor.constraint(equalTo: logoutView.topAnchor, constant: 30),
            logoutLabel.leadingAnchor.constraint(equalTo: logoutView.leadingAnchor, constant: 30),
            
            logoutImageView.bottomAnchor.constraint(equalTo: logoutView.bottomAnchor, constant: -20),
            logoutImageView.trailingAnchor.constraint(equalTo: logoutView.trailingAnchor, constant: -20),
            logoutImageView.widthAnchor.constraint(equalToConstant: 100),
            logoutImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        UserWebService.getUserById(userId: UserDefaults.standard.integer(forKey: "uId")) { user, error in
            if let user = user {
                self.currentUser = user
                DispatchQueue.main.async {
                    self.nameLabel.text = "\(user.firstname) \(user.lastname)"
                    self.professionLabel.text = self.professionLabelText(for: user.profession)
                    self.emailLabel.text = "\(user.email)"
                }
            } else if let error = error {
                print("Error fetching user:", error)
                self.nameLabel.text = "Default error"
                self.professionLabel.text = ""
                self.emailLabel.text = ""
            }
        }
    }
    
    //
    func professionLabelText(for profession: Int) -> String {
        switch profession {
            case 0: return "Bénévole"
            case 1: return "Assistant médical"
            default: return "Default"
        }
    }
    
    @objc func editProfileViewTapped() {
        let editProfileVC = EditProfileViewController()
        print("valid")
        editProfileVC.currentUser = currentUser
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc func logoutButtonTapped() {
        // Action when logout button is tapped
    }
}
