//
//  HomeViewController.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func pushToRegister(_ sender: Any) {
        let register = RegisterMainViewController.newInstance()
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    @IBAction func pushToLogin(_ sender: Any) {
        let login = LoginViewController.newInstance()
        self.navigationController?.pushViewController(login, animated: true)
    }
}
