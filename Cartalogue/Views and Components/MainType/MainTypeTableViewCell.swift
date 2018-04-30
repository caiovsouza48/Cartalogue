//
//  MainTypeTableViewCell.swift
//  Cartalogue
//
//  Created by Caio de Souza on 27/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//

import UIKit

class MainTypeTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var mainTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
