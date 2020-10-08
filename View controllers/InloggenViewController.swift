//
//  InloggenViewController.swift
//  Swipeable
//
//  Created by Annemieke Boomkamp on 05/03/2020.
//  Copyright © 2020 Annemieke Boomkamp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class InloggenViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailadresTextField: UITextField!
   
    @IBOutlet weak var wachtwoordTextField: UITextField!
    
    @IBOutlet weak var inloggenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String? {
        
        if  emailadresTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           wachtwoordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Nog niet alle velden zijn ingevuld"
        }
        return nil
    }
    
    @IBAction func inloggenTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            self.errorLabel.text = error!
            self.errorLabel.alpha = 1
        }
        else {
            let emailadres = emailadresTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let wachtwoord = wachtwoordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: emailadres, password: wachtwoord) { (result, error) in
                
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                } else {
                    let homepageViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homepageViewController) as? HomepageViewController
                    
                    self.view.window?.rootViewController = homepageViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
}
