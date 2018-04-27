//
//  PlanTableViewCell.swift
//  APlanner
//
//  Created by Yijun Shao on 4/24/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackCollectionView: UICollectionView!
   
    @IBOutlet weak var Interest: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension PlanTableViewCell{
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        trackCollectionView.delegate = dataSourceDelegate
        trackCollectionView.dataSource = dataSourceDelegate
        trackCollectionView.tag = row
        trackCollectionView.reloadData()
    }
   
}
