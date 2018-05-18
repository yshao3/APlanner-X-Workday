//
//  PlanTableViewController.swift
//  APlanner
//
//  Created by Yijun Shao on 4/24/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class PlanTableViewController: UIViewController, UITableViewDelegate,UICollectionViewDelegate,UITableViewDataSource,UICollectionViewDataSource {
   
    @IBOutlet weak var PlanTableView: UITableView!
    
    var tags:[String:[String]] = [:]
    var images:[String:[UIImage]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        PlanTableView.delegate = self
        PlanTableView.dataSource = self
        let node:Data = UserDefaults.standard.object(forKey: "profile") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: node) as! User
        tags = loadTags(major: user.Major)
        images = loadImage(major: user.Major)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print (tags.count)
        return tags.count
    }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yes",
                                                 for: indexPath) as! PlanTableViewCell
    cell.Interest.text = Array(tags)[indexPath.row].key
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? PlanTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array(tags)[collectionView.tag].value.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "no",
                                                      for: indexPath as IndexPath) as! PlanCollectionViewCell
        
        cell.track.text = Array(tags)[collectionView.tag].value[indexPath.item]
        cell.TrackImage.image = Array(images)[collectionView.tag].value[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("I'm here")
        let mainStoryboard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
//        let desVC = mainStoryboard.instantiateViewController(withIdentifier:"TrackViewController") as! TrackViewController
        let desVC = mainStoryboard.instantiateViewController(withIdentifier:"test") as! testViewController
        desVC.track = Array(tags)[collectionView.tag].value[indexPath.item]
        desVC.im = Array(images)[collectionView.tag].value[indexPath.item]
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
