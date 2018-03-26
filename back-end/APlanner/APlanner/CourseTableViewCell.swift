//
//  CourseTableViewCell.swift
//  APlanner
//
//  Created by MLyu on 21/03/2018.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var CourseNumber: UILabel!
    @IBOutlet weak var CourseNameButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
