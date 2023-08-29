import UIKit

class DetailsViewController: UIViewController {
    
    var requete: Requete!
    var isAll: Bool!
    
    static func newInstance(requete: Requete, isAll: Bool) -> DetailsViewController {
        let controller = DetailsViewController()
        controller.requete = requete
        controller.isAll = isAll
        return controller
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titre"
        label.textColor = .black
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
    
    let abandonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Abandonner la mission", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(abandonButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let takeButton: UIButton = {
        let button = UIButton()
        button.setTitle("S'inscrire à la mission", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(registerTaskButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.titleLabel.text = "\(self.requete.title)"
        
        view.addSubview(titleLabel)
        view.addSubview(userInfoView)
        userInfoView.addSubview(nameLabel)
        userInfoView.addSubview(subjectLabel)
        
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
        ])
        
        // Ajoutez le bouton approprié en fonction de la valeur de isAll
        if isAll {
            // Ajoutez le bouton pour s'inscrire à la mission
            view.addSubview(takeButton)
            
            NSLayoutConstraint.activate([
                takeButton.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 20),
                takeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                takeButton.widthAnchor.constraint(equalToConstant: 200),
                takeButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        } else {
            // Ajoutez le bouton pour abandonner la mission
            view.addSubview(abandonButton)
            
            NSLayoutConstraint.activate([
                abandonButton.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 20),
                abandonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                abandonButton.widthAnchor.constraint(equalToConstant: 200),
                abandonButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    @objc func abandonButtonTapped() {
        // Action when abandon button is tapped
    }
    
    @objc func registerTaskButtonTapped() {
        // Action when register button is tapped
    }
}
