//
//  ViewController.swift
//  petMeetUp
//
//  Created by Imran Shah on 23/10/2018.
//  Copyright © 2018 Imran Shah. All rights reserved.
//

import UIKit
import Firebase

class LoginViewContoller: UIViewController {

    //Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // variables
    
    
    // constants
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userDefaults.bool(forKey: "userSignedIn") {
            self.performSegue(withIdentifier: "show_Sign_In", sender: self)

        }
    }

    @IBAction func didTappedLoginButton(_ sender: Any) {
        signInUser(email: usernameTextField.text!, password: passwordTextField.text!)
        
    }
    
//    func login(){
//        Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
//
//            if(error != nil){
//                print("No User Found!")
//
//            }else {
//                print("Success - Logged in as\(user)")
//            }
//        }
//    }
    func createUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if error == nil{
                // User Created
                print("User Created")
                // Sign in user
                self.signInUser(email: email, password: password)
                
            }else {
            print(error?.localizedDescription)
        }
    }
}

    func signInUser(email: String, password:String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                // Signed in
                print("User Signed In")
                self.performSegue(withIdentifier: "show_Sign_In", sender: self)
                self.userDefaults.setValue(true, forKey: "userSignedIn")
                self.userDefaults.synchronize()
           
//                let homeViewContoller = self.storyboard?.instantiateViewController(withIdentifier: "homeViewContoller") as! HomeViewController
//
//                self.navigationController?.pushViewController(homeViewContoller, animated: true)
//
//                
                let vc : HomeViewController = self.storyboard!.instantiateViewController(withIdentifier: "homeViewContoller") as! HomeViewController
                let navigationController = UINavigationController(rootViewController: vc)

                self.present(navigationController, animated: true, completion: nil)

            }else {
                print(error)
                print(error?.localizedDescription)
            }
        }
    }
    
}

