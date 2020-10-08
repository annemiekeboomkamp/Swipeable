//
//  FavorietenTableViewCell.swift
//  Swipeable
//
//  Created by Annemieke Boomkamp on 16/03/2020.
//  Copyright © 2020 Annemieke Boomkamp. All rights reserved.
//

import UIKit

class FavorietenTableViewCell: UITableViewCell {

    @IBOutlet weak var naamTableView: UILabel!
    
    @IBOutlet weak var prijsTableView: UILabel!

    @IBOutlet weak var fotoTableView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
