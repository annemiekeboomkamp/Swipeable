//
//  FavorietenViewController.swift
//  Swipeable
//
//  Created by Annemieke Boomkamp on 16/03/2020.
//  Copyright © 2020 Annemieke Boomkamp. All rights reserved.
//

import UIKit

class FavorietenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomepageViewController.favorietenData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavorietenTableViewCell
        
        cell.naamTableView.text = HomepageViewController.naamData[HomepageViewController.favorietenData[indexPath.row]]
        cell.prijsTableView.text = HomepageViewController.prijsData[HomepageViewController.favorietenData[indexPath.row]]
        
        let url = URL(string: HomepageViewController.fotoData[HomepageViewController.favorietenData[indexPath.row]])
        let data = try? Data(contentsOf: url!)
        cell.fotoTableView.image = UIImage(data: data!)
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = HomepageViewController.urlData[HomepageViewController.favorietenData[indexPath.row]]
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded)
        {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            HomepageViewController.favorietenData.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }

}
