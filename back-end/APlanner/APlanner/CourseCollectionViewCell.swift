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
//
    @IBOutlet weak var numberLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!
//    var numberLabel: UILabel!
//    var titleLabel: UILabel!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        frame.size.width = 300
////        frame.size.height = 100
////
////        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
////        imageView.contentMode = UIViewContentMode.ScaleAspectFit
////        contentView.addSubview(imageView)
//
////        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width/2, height: frame.size.height/3))
////        titleLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height/2, width: frame.size.width, height: frame.size.height * 2 / 3))
//        contentView.addSubview(numberLabel)
//        contentView.addSubview(titleLabel)
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
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
