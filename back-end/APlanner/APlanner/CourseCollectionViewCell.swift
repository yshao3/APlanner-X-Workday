//
//  CourseCollectionViewCell.swift
//  APlanner
//
//  Created by MLyu on 22/03/2018.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    //var textLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func displayContent(numberLabel: String, titleLabel: String) {
        self.numberLabel.text = numberLabel
        self.titleLabel.text = titleLabel
    }
    
    
    
}
