//
//  CourseTableViewCell.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var course = loadSampleCourse()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //titleLabel.adjustsFontSizeToFitWidth = true
        //toggleButton.setTitleColor(color: , for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func setInValidInfo(_ sender: UIButton) {
        
        if !check_pre_filled(node: course) {
            toggleButton.isHidden = false
            toggleButton.tintColor = UIColor.orange
            toggleButton.isSelected = !toggleButton.isSelected
            if toggleButton.isSelected {
                titleLabel.text = "Prerequisites unfullfilled."
            } else {
                titleLabel.text = course.title
            }
        } else {
            toggleButton.isHidden = true
            toggleButton.tintColor = UIColor(displayP3Red: 0.0, green: 112/255, blue: 1, alpha: 1)
        }
    }
}
