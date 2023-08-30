//
//  MyRequestViewController.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import UIKit

class MyRequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ongoingLabel: UILabel!
    @IBOutlet weak var ongoingTableView: UITableView!
    
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var myrequestsLabel: UILabel!
    
    var ongoingRequests: [RequeteSub]?
    var doneRequests: [RequeteSub]?
    
    class func newInstance() -> MyRequestViewController {
        let myrequestViewController = MyRequestViewController()
        
        return myrequestViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ongoingTableView.dataSource = self
        self.ongoingTableView.delegate = self
        
        let ongoingCellNib = UINib(nibName: "MyRequestTableViewCell", bundle: nil)
        self.ongoingTableView.register(ongoingCellNib, forCellReuseIdentifier: "OngoingCellId")
        
        self.doneTableView.dataSource = self
        self.doneTableView.delegate = self
        
        let doneCellNib = UINib(nibName: "DoneTableViewCell", bundle: nil)
        self.doneTableView.register(doneCellNib, forCellReuseIdentifier: "DoneCellId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Retrieve ongoing requests
        RequeteSubWebService.getAllRequeteSub { ongoingRequests, _ in
            self.ongoingRequests = ongoingRequests
            
            DispatchQueue.main.async {
                self.ongoingTableView.reloadData()
            }
        }
        
        // Retrieve done requests
        RequeteSubWebService.getAllRequeteSub { doneRequests, _ in
            self.doneRequests = doneRequests
            
            DispatchQueue.main.async {
                self.doneTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ongoingTableView {
            return self.ongoingRequests?.count ?? 0
        } else if tableView == doneTableView {
            return self.doneRequests?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ongoingTableView {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingCellId", for: indexPath) as! MyRequestTableViewCell
                
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
            } else if tableView == doneTableView {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DoneCellId", for: indexPath) as! DoneTableViewCell
                
                if let doneRequests = self.doneRequests?[indexPath.row] {
                    // Obtenir les détails de la requête associée à ce RequeteSub
                    RequeteWebService.getRequeteById(id: doneRequests.requete) { requete, _ in
                        if let requeteDetails = requete {
                            DispatchQueue.main.async {
                                cell.redraw(with: requeteDetails)
                            }
                        }
                    }
                }
            }
            
            return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == ongoingTableView {
                if let ongoingRequest = self.ongoingRequests?[indexPath.row] {
                    // Obtenir les détails de la requête associée à ce RequeteSub
                    RequeteWebService.getRequeteById(id: ongoingRequest.requete) { requete, _ in
                        if let requeteDetails = requete {
                            DispatchQueue.main.async {
                                let next = DetailsViewController.newInstance(requete: requeteDetails, isAll: false)
                                self.navigationController?.pushViewController(next, animated: true)
                            }
                        }
                    }
                }
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
    }
}
