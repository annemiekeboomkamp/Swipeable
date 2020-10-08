//
//  AccountAanmakenViewController.swift
//  Swipeable
//
//  Created by Annemieke Boomkamp on 05/03/2020.
//  Copyright © 2020 Annemieke Boomkamp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountAanmakenViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var voornaamTextField: UITextField!

    @IBOutlet weak var achternaamTextField: UITextField!
    
    @IBOutlet weak var emailadresTextField: UITextField!
   
    @IBOutlet weak var wachtwoordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        errorLabel.alpha = 0
    }
    
    //Bron: https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailadresValid(_ emailadres : String) -> Bool{
        let emailadresTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}")
        return emailadresTest.evaluate(with: emailadres)
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() -> String? {
        
        if voornaamTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           achternaamTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           emailadresTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           wachtwoordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Nog niet alle velden zijn ingevuld"
        }
        
        let goedEmailadres = emailadresTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isEmailadresValid(goedEmailadres) == false {
            return "Emailadres is niet geldig"
        }
        
        let goedWachtwoord = wachtwoordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(goedWachtwoord) == false {
            return "Wachtwoord moet minstens 8 karakters hebben waarvan minstens 1 bijzonder karakter en 1 nummer"
        }
        
        return nil
    }
    
    func transitionToHomepage() {
        let homepageViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homepageViewController) as? HomepageViewController
        
        view.window?.rootViewController = homepageViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func accountAanmakenTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            
            let voornaam = voornaamTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let achternaam = achternaamTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailadres = emailadresTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let wachtwoord = wachtwoordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: emailadres, password: wachtwoord) { (result, err) in
                
                if err != nil {
                    self.showError("Error account aanmaken")
                }
                else {
                    let db = Firestore.firestore()
                    
                    db.collection("gebruikers").addDocument(data: ["voornaam":voornaam, "achternaam":achternaam, "uid": result!.user.uid]) { (error) in
                        
                        
                        if error != nil {
                            self.showError("Error opslaan gebruikers data")
                        }
                    }
                    
                    self.transitionToHomepage()
                }
            }
        }
    }
}
