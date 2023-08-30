//
//  AllHomeViewController.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 20/08/2023.
//

import UIKit

class AllHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var checkAllRequestButton: UIButton!
    @IBOutlet weak var availabletasksLabel: UILabel!
    @IBOutlet weak var howudoingLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var myOngoingRequestTableView: UITableView!
    @IBOutlet weak var yourRequestsLabel: UILabel!
    
    var ongoingRequests: [RequeteSub]?
    var loggedInUserId: Int?
        
        class func newInstance() -> AllHomeViewController {
            let allHomeViewController = AllHomeViewController()
            return allHomeViewController
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.myOngoingRequestTableView.dataSource = self
            self.myOngoingRequestTableView.delegate = self
            
            let cellNib = UINib(nibName: "AllHomeTableViewCell", bundle: nil)
            self.myOngoingRequestTableView.register(cellNib, forCellReuseIdentifier: "AllHomeCellId")
            
            checkAllRequestButton.addTarget(self, action: #selector(checkAllRequestButtonTapped), for: .touchUpInside)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let userId = UserDefaults.standard.integer(forKey: "uId")
            
            // Vérifier si l'ID de l'utilisateur est valide
            if userId != 0 {
                loggedInUserId = userId
                
                // Récupérer les détails de l'utilisateur connecté
                UserWebService.getUserById(userId: userId) { user, _ in
                    if let userDetails = user {
                        DispatchQueue.main.async {
                            self.usernameLabel.text = userDetails.firstname
                        }
                    }
                }
            }

            // Retrieve ongoing requests
            RequeteSubWebService.getAllRequeteSub { ongoingRequests, _ in
                self.ongoingRequests = ongoingRequests
                
                DispatchQueue.main.async {
                    self.myOngoingRequestTableView.reloadData()
                }
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.ongoingRequests?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllHomeCellId", for: indexPath) as! AllHomeTableViewCell
            
            if let ongoingRequest = self.ongoingRequests?[indexPath.row] {
                // Obtenir les détails de la requête associée à ce RequeteSub
                RequeteWebService.getRequeteById(id: ongoingRequest.requete) { requete, _ in
                    if let requeteDetails = requete {
                        DispatchQueue.main.async {
                            cell.redraw(with: requeteDetails)
                        }
                    }
                }
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        @objc func checkAllRequestButtonTapped() {
            let allRequestVC = AllRequestViewController.newInstance()
            self.navigationController?.pushViewController(allRequestVC, animated: true)
        }

}
