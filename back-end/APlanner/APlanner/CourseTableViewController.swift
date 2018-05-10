//
//  CourseTableViewController.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit
import os.log

class CourseTableViewController: UITableViewController {
    
    var model: [Int: Semester] = [Int: Semester]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //edit = editButtonItem
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = UIColor.white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        // Load any saved meals, otherwise load sample data.
//        if let saveModel = loadSemester_disk() {
//            model = saveModel
//        } else {
//            model = loadSemester()
//        }
        
        //saveSemester()
        check_model_key()
        model = GloVar.scheduler//loadSemester()
        tableView.reloadData()
        //self.navigationController?.navigationBar.barTintColor = UIColor.green
    }
//    override func viewDidAppear(_ animated: Bool) {
//        //self.viewDidLoad()
//        super.viewDidAppear(animated)
//        //preTableView.reloadData()
//        //self.navigationController?.navigationBar.barTintColor = UIColor.green
//
//    }
    override func viewWillAppear(_ animated: Bool) {
        check_model_key()
        self.viewDidLoad()
        print(model)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return model.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model[section]!.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CourseTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CourseTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        
        let course = model[indexPath.section]?.courses[indexPath.row]
        
        cell.courseLabel.text = course?.course
        cell.titleLabel.text = course?.title
        cell.course = course!
//        cell.photoImageView.image = meal.photo
//        cell.ratingControl.rating = meal.rating
        print("check" + (course?.course)!)
        //print(check_pre_filled(node: course!))
        if !check_pre_filled(node: course!) {
            cell.toggleButton.isHidden = false
            cell.toggleButton.tintColor = UIColor.orange
        } else {
            cell.toggleButton.isHidden = true
            cell.toggleButton.tintColor = UIColor(displayP3Red: 0.0, green: 112/255, blue: 1, alpha: 1)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return model[section]?.time
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let c = model[indexPath.section]?.courses[indexPath.row]
            model[indexPath.section]?.courses.remove(at: indexPath.row)
            saveSemester()
            tableView.deleteRows(at: [indexPath], with: .fade)
            GloVar.courseDict[(c?.course)!]?.inScheduler = false
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        GloVar.scheduler = model
    }
    

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
    @IBAction func unwindToScheduler(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? PageViewController {
            let course = sourceViewController.course
            let term = sourceViewController.term
            let year = sourceViewController.year
            var i = 0
            var j = 0
            var flag = 0
            for (key, sem) in model {
                i = 0
                for c in sem.courses {
                    if course.course == c.course {
                        flag = 1
                        j = key
                        break
                    }
                    i += 1
                }
                if flag == 1 {
                    break
                }
            }
            if flag == 1 {
                model[j]?.courses.remove(at: i)
                course.inScheduler = false
                print("Delete course" + course.course)
//                let indexPath = IndexPath(row: i, section: j)
//                tableView.deleteRows(at: [indexPath], with: .fade)
                GloVar.courseDict[course.course]?.inScheduler = false
            } else {
                let section = addToSemester(cur_year: year, cur_term: term)
                
                if model[section] == nil { //section >= model.count || 
//                    tableView.beginUpdates()
//                    tableView.insertSections(IndexSet(integer: section), with: .automatic)
                    model[section] = Semester(time: term + " " + year, courses: [])
//                    tableView.endUpdates()
                }
                
                // TODO: what if add to a semester which does not have a course???
//                let newIndexPath = IndexPath(row: (model[section]?.count())!, section: section)
                course.inScheduler = true
                model[section]?.addCourse(course: course)
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
                print("Add course" + course.course)
                GloVar.courseDict[course.course]?.inScheduler = true
            }
            saveSemester()
            GloVar.scheduler = model
            check_model_key()
            print(GloVar.scheduler)
            print("unwind")
            model = GloVar.scheduler
//
            tableView.reloadData()
        }
        print("unwind 2 ")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
            case "AddItem":
                //os_log("Adding a new meal.", log: OSLog.default, type: .debug)
                guard segue.destination is SearchTableViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
//                guard segue.destination is UINavigationController else {
//                    fatalError("Unexpected destination: \(segue.destination)")
//                }
            
            case "ShowDetail":
//                guard let navController = segue.destination as? UINavigationController else {
//                    fatalError("Unexpected destination: \(segue.destination)")
//                }
//                guard let pageDetailViewController = navController.viewControllers[0] as? PageViewController else {
//                    fatalError("Unexpected next view")
//                }
                guard let pageDetailViewController = segue.destination as? PageViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedCourseCell = sender as? CourseTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedCourseCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedCourse = model[indexPath.section]?.courses[indexPath.row]
                
                pageDetailViewController.course = selectedCourse!
            
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    private func saveSemester() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(model, toFile: Semester.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Model successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadSemester_disk() -> [Int: Semester]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Semester.ArchiveURL.path) as? [Int: Semester]
    }
}
