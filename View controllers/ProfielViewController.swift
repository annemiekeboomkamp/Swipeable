//
//  ProfielViewController.swift
//  Swipeable
//
//  Created by Annemieke Boomkamp on 17/03/2020.
//  Copyright © 2020 Annemieke Boomkamp. All rights reserved.
//

import UIKit
//import FirebaseAuth

class ProfielViewController: UIViewController {

    @IBOutlet weak var voornaamInformatie: UITextField!
    @IBOutlet weak var achternaamInformatie: UITextField!
    @IBOutlet weak var emailadresInformatie: UITextField!
    @IBOutlet weak var wachtwoordInformatie: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*let user = Auth.auth().currentUser
        if let user = user {
            achternaamInformatie.text = user.displayName
            voornaamInformatie.textColor = UIColor.white
            achternaamInformatie.text = user.displayName
            achternaamInformatie.textColor = UIColor.white
            emailadresInformatie.text = user.email
            emailadresInformatie.textColor = UIColor.white
            wachtwoordInformatie.text = "•••••••"
            wachtwoordInformatie.textColor = UIColor.white
        }*/
    }
}
