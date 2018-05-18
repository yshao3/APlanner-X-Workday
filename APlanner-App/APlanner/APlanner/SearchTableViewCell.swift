//
//  SearchTableViewCell.swift
//  APlanner
//
//  Created by MLyu on 2018/4/16.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNumSrch: UILabel!
    @IBOutlet weak var courseTitleSrch: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
