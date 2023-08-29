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
    
    var ongoingRequests: [Requete]?
    var doneRequests: [Requete]?
    
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
        
        let doneCellNib = UINib(nibName: "DoneRequestTableViewCell", bundle: nil)
        self.doneTableView.register(doneCellNib, forCellReuseIdentifier: "DoneCellId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Retrieve ongoing requests
        RequeteWebService.getOngoingRequetes { ongoingRequests, _ in
            self.ongoingRequests = ongoingRequests
            
            DispatchQueue.main.async {
                self.ongoingTableView.reloadData()
            }
        }
        
        // Retrieve done requests
        RequeteWebService.getDoneRequetes { doneRequests, _ in
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingCellId", for: indexPath) as! OngoingRequestTableViewCell
            cell.redraw(with: self.ongoingRequests![indexPath.row])
            return cell
        } else if tableView == doneTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoneCellId", for: indexPath) as! DoneRequestTableViewCell
            cell.redraw(with: self.doneRequests![indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == ongoingTableView {
            if let ongoingRequest = self.ongoingRequests?[indexPath.row] {
                let next = DetailsViewController.newInstance(requete: ongoingRequest, isAll: false)
                self.navigationController?.pushViewController(next, animated: true)
            }
        } else if tableView == doneTableView {
            if let doneRequest = self.doneRequests?[indexPath.row] {
                let next = DetailsViewController.newInstance(requete: doneRequest, isAll: false)
                self.navigationController?.pushViewController(next, animated: true)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
