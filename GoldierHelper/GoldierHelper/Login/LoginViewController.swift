//
//  LoginViewController.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var mailTxtField: UITextField!
    @IBOutlet weak var forgotBtn: UIButton!
    
    class func newInstance() -> LoginViewController {
        let loginViewController = LoginViewController()
        
        return loginViewController
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handleConnect(_ sender: Any) {
        
        if (mailTxtField.hasText && passwordTxtField.hasText){
            let parameters = "{\n    \"email\" : \"\(mailTxtField.text!)\",\n    \"password\" : \"\(passwordTxtField.text!)\"\n}"
                UserWebService.loginUser(parameters: parameters)

        }
        
        else{
            print("MARCHE PAS")
        }
    }
    
    
    @objc func handleTapOnView(gesture: UITapGestureRecognizer) {
        self.mailTxtField.resignFirstResponder()
        self.view.removeGestureRecognizer(gesture)
    }
    
    // Event déclenché lorsque le clavier est disponible pour le textfield
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnView(gesture:)))
        self.view.addGestureRecognizer(tap)
    }
    
    // Event déclenché lorsque l'utilisateur clique sur le bouton retour
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // ferme le clavier
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change chars")
        guard let NSText = textField.text as? NSString else {
            return true
        }
        print("here")
        let realText = NSText.replacingCharacters(in: range, with: string)
        print(realText)
        if realText.count > 0 {
            self.loginBtn.isEnabled = true
        } else {
            self.loginBtn.isEnabled = false
        }
        return true
    }
    
    
    func tabNextViews(){
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = hexStringToUIColor(hex: "#a5ce63")
        
        
        let allRequestViewController = AllRequestViewController()
        allRequestViewController.tabBarItem.title = NSLocalizedString("controllers.tabbar.allrequest", comment: "")
        //allRequestViewController.tabBarItem.image = resizeImage(image: UIImage(named: "allRequests")!, targetSize: CGSizeMake(27.0, 27.0))
        
        let myRequestViewController = MyRequestViewController()
        myRequestViewController.tabBarItem.title = NSLocalizedString("controllers.tabbar.myrequest", comment: "")
        //myRequestViewController.tabBarItem.image = resizeImage(image: UIImage(named: "dumbbell")!, targetSize: CGSizeMake(27.0, 27.0))
        
        let accountViewController = AccountViewController()
        accountViewController.tabBarItem.title = NSLocalizedString("controllers.tabbar.account", comment: "")
        //favoritesViewController.tabBarItem.image = resizeImage(image: UIImage(named: "favorites-star")!, targetSize: CGSizeMake(27.0, 27.0))
        
        tabBarController.viewControllers = [
            allRequestViewController,
            myRequestViewController,
            accountViewController
        ]
        
        self.navigationController?.pushViewController(tabBarController,animated: true)
    }
}
