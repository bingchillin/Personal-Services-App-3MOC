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
        self.nameLabel.text = "Une personne agée à besoin d'aide"
        if self.requete.type == 1 {
            self.subjectLabel.text = "Tâches ménagères"
        }
        if self.requete.type == 2 {
            self.subjectLabel.text = "Alimentation"
        }
        
        
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
        if let userId = UserDefaults.standard.string(forKey: "uId"),
           let requeteId = self.requete.id {
        
            // Créez ici les paramètres pour la soumission de la requête d'abandon
            let abandonParameters = "{\n    \"requete\" : \(requeteId), \n    \"user\" : \"\(userId)\"\n}"
            
            // Appelez la fonction pour créer la requête d'abandon
            RequeteSubWebService.createSubRequest(parameters: abandonParameters) { success in
                DispatchQueue.main.async {
                    if success {
                        print("Abandon request creation success")
                        let next = MyRequestViewController.newInstance()
                        self.navigationController?.pushViewController(next, animated: true)

                    } else {
                        print("Abandon request creation failed")
                        
                        // Si la création de la requête d'abandon échoue, affichez un message d'erreur
                        let alertController = UIAlertController(title: "Erreur", message: "Vous ne pouvez pas abandonner cette mission. Veuillez réessayer.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else {
            print("User ID or Requete ID not found")
        }
    }

    
    @objc func registerTaskButtonTapped() {
        if let userId = UserDefaults.standard.string(forKey: "uId"),
           let requeteId = self.requete.id {
        
            let subRequestParameters = "{\n    \"requete\" : \(requeteId), \n    \"user\" : \"\(userId)\",\n    \"accepted\" : false\n}"
            
            print(subRequestParameters)
            
            RequeteSubWebService.createSubRequest(parameters: subRequestParameters) { success in
                DispatchQueue.main.async {
                    if success {
                        print("Sub-request creation success")
                        let next = MyRequestViewController.newInstance()
                        self.navigationController?.pushViewController(next, animated: true)

                    } else {
                        print("Sub-request creation failed")
                        
                        // If the creation of sub-request fails, show an error message
                        let alertController = UIAlertController(title: "Erreur", message: "Vous ne pouvez pas vous inscrire à cette mission. Veuillez réessayer.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else {
            print("User ID or Requete ID not found")
        }
    }




}
