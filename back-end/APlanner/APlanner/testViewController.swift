//
//  testViewController.swift
//  APlanner
//
//  Created by Yijun Shao on 5/2/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class testViewController: UIViewController, UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource {
    var track = ""
    var im = UIImage()
    @IBOutlet weak var name: UILabel!
    //    @IBOutlet weak var track: UILabel!
    var cores:[String] = []
    var fullplan:[[String]] = []
    @IBOutlet weak var corecourses: UICollectionView!
    var course_dic = load_dict()
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cores = loadCore(track:track)
        fullplan = loadPlan(core: cores)
        
        name.textColor = UIColor.white
        name.text = track
        
        image.image = im
        view.addSubview(scrollview)

        // Do any additional setup after loading the view.
    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullplan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fullplan",for: indexPath) as! CoreTableViewCell
        let x = indexPath.row + 1
        cell.year.text = "Level " + String(x)
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CoreTableViewCell  else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        if collectionView == corecourses{
            
          let desVC = mainStoryboard.instantiateViewController(withIdentifier:"PageViewController") as! PageViewController
//            print(cores[indexPath.item])
            if let tmp_cour = course_dic[cores[indexPath.item]] {
                desVC.course = tmp_cour
                self.navigationController?.pushViewController(desVC, animated: true)
            }
        }else{
            let desVC = mainStoryboard.instantiateViewController(withIdentifier:"PageViewController") as! PageViewController
//            print(Array(fullplan)[collectionView.tag][indexPath.item])
            
            if let tmp_cour = course_dic[Array(fullplan)[collectionView.tag][indexPath.item]] {
            desVC.course = tmp_cour
            self.navigationController?.pushViewController(desVC, animated: true)
        }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == corecourses{
            return cores.count}
        else{
            return Array(fullplan)[collectionView.tag].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == corecourses{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "np",for: indexPath as IndexPath) as! testCollectionViewCell
            cell.core.text = cores[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "course",for: indexPath as IndexPath) as! FullPlanCollectionViewCell
        //    print(fullplan)
        //    print(collectionView.tag)
        cell.name.text = Array(fullplan)[collectionView.tag][indexPath.item]
        return cell
        
    }
//    -(void)gestureAction:(UITapGestureRecognizer *) sender
//    {
//    CGPoint touchLocation = [sender locationOfTouch:0 inView:self.YourCollectionViewName];
//    NSIndexPath *indexPath = [self.YourCollectionViewName indexPathForRowAtPoint:touchLocation];
//
//    NSLog(@"%d", indexPath.item);
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
