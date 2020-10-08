//
//  HomepageViewController.swift
//  Swipeable
//
//  Created by Annemieke Boomkamp on 05/03/2020.
//  Copyright © 2020 Annemieke Boomkamp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var fotoItem: UIImageView!
    
    @IBOutlet weak var naamLabel: UILabel!
    
    @IBOutlet weak var prijsLabel: UILabel!
    
    public static var naamData = [String]()
    public static var prijsData = [String]()
    public static var fotoData = [String]()
    public static var urlData = [String]()
    
    public static var indexData = [Int]()
    public static var favorietenData = [Int]()
    public static var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for _ in 5...9 {
            let randomInt = Int.random(in: 0...9)
            HomepageViewController.configureDatabase(random: randomInt)
        }
        volgendePlaatje(getal: HomepageViewController.index)
    }
    
    @IBAction func winkelTapped(_ sender: Any) {
        let url = HomepageViewController.urlData[HomepageViewController.index]
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded)
        {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func kruisTapped(_ sender: Any) {
        if HomepageViewController.index + 1 < HomepageViewController.naamData.count {
            HomepageViewController.index = HomepageViewController.index + 1
            volgendePlaatje(getal: HomepageViewController.index)
        }
    }
    
    @IBAction func hartTapped(_ sender: Any) {
        if HomepageViewController.index + 1 < HomepageViewController.naamData.count {
            HomepageViewController.index = HomepageViewController.index + 1
            volgendePlaatje(getal: HomepageViewController.index)
            HomepageViewController.favorietenData.append(HomepageViewController.index)
        }
    }
    
    func volgendePlaatje(getal:Int) {
        self.naamLabel.text = HomepageViewController.naamData[getal]
        self.prijsLabel.text = HomepageViewController.prijsData[getal]
        let url = URL(string: HomepageViewController.fotoData[getal])
        let data = try? Data(contentsOf: url!)
        self.fotoItem.image = UIImage(data: data!)
    }
    
    public static func configureDatabase(random:Int) {
        let db = Firestore.firestore()
        
        if HomepageViewController.indexData.contains(random) == false {
            HomepageViewController.indexData.append(random)
            let intString = String(random)
            let docRef = db.collection("items").document(intString)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    HomepageViewController.naamData.append(dataDescription?["naam"] as! String)
                    HomepageViewController.prijsData.append(dataDescription?["prijs"] as! String)
                    HomepageViewController.fotoData.append(dataDescription?["foto"] as! String)
                    HomepageViewController.urlData.append(dataDescription?["url"] as! String)
                } else {
                    print("Document does not exist")
                }
            }
        } else {
            let randomInt = Int.random(in: 0...9)
            configureDatabase(random: randomInt)
        }
    }
}
