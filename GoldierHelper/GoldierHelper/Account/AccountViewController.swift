import UIKit

class AccountViewController: UIViewController {
    
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
        label.text = "John Doe"
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
        label.text = "Bénévole"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubview(titleLabel)
        
        view.addSubview(userInfoView)
        userInfoView.addSubview(nameLabel)
        userInfoView.addSubview(professionLabel)
        
        view.addSubview(editProfileView)
        editProfileView.addSubview(editProfileLabel)
        editProfileView.addSubview(descriptionLabel)
        
        view.addSubview(logoutView)
        logoutView.addSubview(logoutLabel)
        
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
            
            editProfileView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 30),
            editProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            editProfileView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            editProfileView.heightAnchor.constraint(equalToConstant: 250),
            
            editProfileLabel.topAnchor.constraint(equalTo: editProfileView.topAnchor, constant: 30),
            editProfileLabel.leadingAnchor.constraint(equalTo: editProfileView.leadingAnchor, constant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: editProfileLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: editProfileView.leadingAnchor, constant: 30),
            
            logoutView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 30),
            logoutView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            logoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            logoutView.heightAnchor.constraint(equalToConstant: 250),
            
            logoutLabel.topAnchor.constraint(equalTo: logoutView.topAnchor, constant: 30),
            logoutLabel.leadingAnchor.constraint(equalTo: logoutView.leadingAnchor, constant: 30),
        ])
    }
    
    @objc func editButtonTapped() {
        // Action when edit button is tapped
    }
    
    @objc func logoutButtonTapped() {
        // Action when logout button is tapped
    }
}
