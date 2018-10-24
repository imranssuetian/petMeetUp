//
//  HomeViewController.swift
//  petMeetUp
//
//  Created by Imran Shah on 23/10/2018.
//  Copyright © 2018 Imran Shah. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var emailOutlet: UILabel!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let email = Auth.auth().currentUser?.email else {return}
        emailOutlet.text = email


    }

    
    @IBAction func didTappedSignOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            userDefault.removeObject(forKey: "userSignedIn")
            userDefault.synchronize()
            self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    
}
