//
//  ViewController.swift
//  Swipeable
//
//  Created by Annemieke Boomkamp on 02/03/2020.
//  Copyright © 2020 Annemieke Boomkamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for _ in 0...4 {
            let randomInt = Int.random(in: 0...9)
            HomepageViewController.configureDatabase(random: randomInt)
        }
    }
    
}

