import UIKit

class DetailsViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ma mission"
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
    
    let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Tâche ménagère"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "242 Rue du Faubourg Saint-Antoine"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let abandonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Abandonner la mission", for: .normal)
        button.backgroundColor = .red
        button.addTarget(MyRequestViewController.self, action: #selector(abandonButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var rdv = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if rdv == 1 {  // Si rdv est égal à 1, afficher le contenu
            view.addSubview(titleLabel)
            view.addSubview(userInfoView)
            userInfoView.addSubview(nameLabel)
            userInfoView.addSubview(subjectLabel)
            userInfoView.addSubview(addressLabel)
            view.addSubview(abandonButton)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
                
                userInfoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
                userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
                userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
                userInfoView.heightAnchor.constraint(equalToConstant: 250),
                
                nameLabel.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 30),
                nameLabel.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 30),
                
                subjectLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
                subjectLabel.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 30),
                
                addressLabel.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 30),
                addressLabel.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: -30),
                
                abandonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                abandonButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                abandonButton.widthAnchor.constraint(equalToConstant: 200),
                abandonButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        } else {  // Sinon, afficher le texte "Vous n'avez pas de mission en cours"
            let emptyLabel = UILabel()
            emptyLabel.text = "Vous n'avez pas de mission en cours"
            emptyLabel.font = UIFont.systemFont(ofSize: 24)
            emptyLabel.textAlignment = .center
            emptyLabel.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(emptyLabel)
            
            NSLayoutConstraint.activate([
                emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    @objc func abandonButtonTapped() {
        // Action when logout button is tapped
    }
}
