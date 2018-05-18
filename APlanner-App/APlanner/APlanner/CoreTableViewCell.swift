//
//  CoreTableViewCell.swift
//  APlanner
//
//  Created by Yijun Shao on 4/29/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class CoreTableViewCell: UITableViewCell
//    ,UICollectionViewDelegate,UICollectionViewDataSource
{

  
    @IBOutlet weak var year: UILabel!
    

    @IBOutlet weak var coursecollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        // Configure the view for the selected state
    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "course",for: indexPath as IndexPath) as! CoreCollectionViewCell
//        cell.name.text = data[indexPath.item]
//        return cell
//
//    }

}
extension CoreTableViewCell{
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        coursecollection.delegate = dataSourceDelegate
        coursecollection.dataSource = dataSourceDelegate
        coursecollection.tag = row
        coursecollection.reloadData()
    }
    
}

