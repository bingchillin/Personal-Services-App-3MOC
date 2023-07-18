//
//  RegisterIdentityViewController.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import UIKit

class RegisterIdentityViewController: UIViewController {
    
    var email: String = ""
        var password: String = ""
        
        class func newInstance(email: String, password: String) -> RegisterIdentityViewController {
            let registerIdentityViewController = RegisterIdentityViewController()
            registerIdentityViewController.email = email
            registerIdentityViewController.password = password
            
            return registerIdentityViewController
        }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
