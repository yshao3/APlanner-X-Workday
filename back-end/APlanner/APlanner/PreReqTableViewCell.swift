//
//  PreReqTableViewCell.swift
//  APlanner
//
//  Created by MLyu on 2018/4/23.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class PreReqTableViewCell: UITableViewCell {

    @IBOutlet weak var preLabel_1: UILabel!
    @IBOutlet weak var preLabel_2: UILabel!
    @IBOutlet weak var preLabel_3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
