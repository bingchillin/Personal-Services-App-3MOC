//
//  RegisterMainViewController.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import UIKit

class RegisterMainViewController: UIViewController {
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var mailTxtField: UITextField!
    
    class func newInstance() -> RegisterMainViewController {
        let registerMainViewController = RegisterMainViewController()
        
        return registerMainViewController
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
     @IBAction func handleNext(_ sender: Any) {
         guard let email = mailTxtField.text,
                      let password = passwordTxtField.text else {
                    return
                }
                
                let registerIdentityViewController = RegisterIdentityViewController.newInstance(email: email, password: password)
                navigationController?.pushViewController(registerIdentityViewController, animated: true)
            
     }
     

}
