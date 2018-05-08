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
    var cores:[Node] = []
    var fullplan:[[Node]] = []
    var model: [Int: Semester] = [:]
    @IBOutlet weak var corecourses: UICollectionView!
//    var course_dic: [String:Node] = [:]
    var course_dic = MyVariables.yourVariable
    var toadd = false
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func AddOrDelete(_ sender: Any) {
        if (toadd){
//            deletefullplan(fullplan: fullplan)
            addordelete.setTitle("Add to my scheduler", for:.normal )
            addordelete.backgroundColor = UIColor.blue
        }else{
            addfullplan(fullplan: fullplan)
            addordelete.setTitle("Delete from my scheduler", for:.normal )
            addordelete.backgroundColor = UIColor.red
        }
        toadd = !toadd
    }
    var tracks:[String] = []
    
    @IBOutlet weak var addordelete: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        course_dic = load_dict()
        cores = loadCore(track:track,course_dic:course_dic)
        fullplan = loadPlan(core: cores,course_dic: course_dic)
        
        name.textColor = UIColor.white
        name.text = track
        model = loadSemester()
        image.image = im
        (tracks, _) = gettrack()
        if tracks.contains(track){
            toadd = true
            addordelete.setTitle("Delete from my scheduler", for:.normal )
            addordelete.backgroundColor = UIColor.red
        }else{
            addordelete.setTitle("Add to my scheduler", for:.normal )
            addordelete.backgroundColor = UIColor(displayP3Red: 5/255, green:194/255, blue: 200/255, alpha: 1.0)
        }
        
        view.addSubview(scrollview)

        // Do any additional setup after loading the view.
    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    func addfullplan(fullplan:[[Node]]){
        let date = Date()
        let calendar = Calendar.current
        var year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        var cur_year = float_t(year)
        var cur_term = ""
        if (month >= 6) {
             cur_term = "Fall"
            cur_year += 0.5
        }else{
            cur_term = "Spring"
            
        }
        
        var index = addToSemester(cur_year: String(year), cur_term: cur_term)
        
        for plan in fullplan{
            for course in plan{
                if (!course.inScheduler){
                    if (model[index]==nil){
                        var term = ""
                        if cur_year > float_t(integer_t(cur_year)){
                            term = "Fall"
                        }else{term = "Spring"}
                        model[index] = Semester(time:String(integer_t(cur_year))+" term",courses:[])
                        
                    }
                    model[index]?.addCourse(course: course);
                    course.inScheduler = true
                
                }
                
            }
            cur_year+=0.5
            index += 1
        }
    }
    func deletefullplan(fullplan:[[Node]]){
        for plan in fullplan{
            for course in plan{

            }
        }
    }
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
            
                desVC.course = cores[indexPath.item]
                self.navigationController?.pushViewController(desVC, animated: true)
            
        }else{
            let desVC = mainStoryboard.instantiateViewController(withIdentifier:"PageViewController") as! PageViewController
//            print(Array(fullplan)[collectionView.tag][indexPath.item])
            
            
            desVC.course = Array(fullplan)[collectionView.tag][indexPath.item]
            self.navigationController?.pushViewController(desVC, animated: true)
        
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
            cell.core.text = cores[indexPath.item].course
            cell.backgroundColor = UIColor(displayP3Red: 90/255, green:200/255, blue: 250/255, alpha: 1.0)
           
                //%16.67. %37.04. %46.30
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "course",for: indexPath as IndexPath) as! FullPlanCollectionViewCell
        //    print(fullplan)
        //    print(collectionView.tag)
        cell.name.text = Array(fullplan)[collectionView.tag][indexPath.item].course
        if  cores.contains(Array(fullplan)[collectionView.tag][indexPath.item]){
            cell.backgroundColor = UIColor(displayP3Red: 90/255, green:200/255, blue: 250/255, alpha: 1.0)
            
            
        }else{
            cell.backgroundColor = UIColor(displayP3Red: 216/255, green:216/255, blue: 216/255, alpha: 1.0)
            cell.name.textColor = UIColor.black
            
        }
       
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
