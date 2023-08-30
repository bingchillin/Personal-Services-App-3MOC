//
//  AllRequestViewController.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import UIKit

class AllRequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var householdRequests : [Requete]?
    var nutritionRequests: [Requete]?
    
    
    class func newInstance() -> AllRequestViewController {
        let allRequestViewController = AllRequestViewController()
        
        return allRequestViewController
    }
    
    @IBOutlet weak var householdTaskTableView: UITableView!
    
    @IBOutlet weak var householdTasksLabel: UILabel!
    @IBOutlet weak var nutritionTableView: UITableView!
    @IBOutlet weak var allRequestLabel: UILabel!
    @IBOutlet var nutritionLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.householdTaskTableView.dataSource = self
        self.householdTaskTableView.delegate = self
        
        let householdCellNib = UINib(nibName: "AllRequestTableViewCell", bundle: nil)
        self.householdTaskTableView.register(householdCellNib, forCellReuseIdentifier: "HouseholdCellId")
    
        
        self.nutritionTableView.dataSource = self
        self.nutritionTableView.delegate = self
        let nutritionCellNib = UINib(nibName: "NutritionTaskTableViewCell", bundle: nil)
        self.nutritionTableView.register(nutritionCellNib, forCellReuseIdentifier: "NutritionCellId")
          
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        RequeteWebService.getHouseholdRequetes { householdRequests, _ in
            self.householdRequests = householdRequests
            print("Household Requests Count: \(self.householdRequests?.count ?? 0)")

            
            DispatchQueue.main.async {
                self.householdTaskTableView.reloadData()
            }
        }
        
        RequeteWebService.getNutritionRequetes { nutritionRequests, _ in
            self.nutritionRequests = nutritionRequests
            print("Nutrition Requests Count: \(self.nutritionRequests?.count ?? 0)")

            DispatchQueue.main.async {
                self.nutritionTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == householdTaskTableView {
            return self.householdRequests?.count ?? 0
        } else if tableView == nutritionTableView {
            return self.nutritionRequests?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == householdTaskTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseholdCellId", for: indexPath) as! AllRequestTableViewCell
            if let householdTask = self.householdRequests?[indexPath.row] {
                cell.redraw(with: householdTask) // Use the unwrapped householdTask here
            }
            return cell
        } else if tableView == nutritionTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionCellId", for: indexPath) as! NutritionTaskTableViewCell
            if let nutritionTask = self.nutritionRequests?[indexPath.row] {
                cell.redraw(with: nutritionTask) // Use the unwrapped nutritionTask here
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == householdTaskTableView, let householdRequests = self.householdRequests {
            if indexPath.row < householdRequests.count {
                let householdTask = householdRequests[indexPath.row]
                let next = DetailsViewController.newInstance(requete: householdTask, isAll: true)
                self.navigationController?.pushViewController(next, animated: true)
            }
        } else if tableView == nutritionTableView, let nutritionRequests = self.nutritionRequests {
            if indexPath.row < nutritionRequests.count {
                let nutritionTask = nutritionRequests[indexPath.row]
                let next = DetailsViewController.newInstance(requete: nutritionTask, isAll: true)
                self.navigationController?.pushViewController(next, animated: true)
            }
        }
    }




}
