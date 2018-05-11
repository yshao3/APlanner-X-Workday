//
//  PageViewController.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit
import os.log

class PageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var preLabel: UILabel!
    @IBOutlet weak var fillLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
//    @IBOutlet weak var addToSchePicker: UIPickerView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var preTableView: UITableView!
    @IBOutlet weak var addToPlanner: UILabel!
    @IBOutlet weak var chooseTerm: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    var course: Node = loadSampleCourse()
    var term = "Fall"
    var year = "2017"

    var comp: [[String]] = [[String]]()
    var courseDict = [String: Node]()//load_dict()
    var course_name = ""
    var addToSchePicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numLabel.text = course.course
        titleLabel.text = course.title
        descLabel.text = course.desc
        termLabel.text = course.term
        whenLabel.text = "Available"
        preLabel.text = "Pre-requisite"
        if check_pre_filled(node: course) {
            fillLabel.text = "Fullfilled"
            fillLabel.textColor = UIColor.black
        } else {
            fillLabel.text = "Unfullfilled"
            fillLabel.textColor = UIColor.red
        }
        
        areaLabel.text = "Academic Area"
        tagLabel.text = course.area
        addToPlanner.text = "Add to planner"
        
        //addToSchePicker.isHidden = false
        //scrollView.addSubview(addToSchePicker)
        addToSchePicker.delegate = self
        addToSchePicker.dataSource = self
        chooseTerm.inputView = addToSchePicker
        
        //chooseTerm.delegate = self
    
        preTableView.delegate = self
        preTableView.dataSource = self
        navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
//        saveButton.isEnabled = false
        if course.inScheduler {
            addButton.setTitle("Remove from Scheduler", for: .normal)
//            addButton.titleLabel = "Remove from Scheduler"
        } else {
            addButton.setTitle("Add to Scheduler", for: .normal)
        }
        preTableView.tableFooterView = UIView(frame: .zero)
        self.preTableView.separatorStyle = .none
        //scrollView.addSubview(preTableView)
        view.addSubview(scrollView)
//        stackView.addSubview(addToSchePicker)
//        self.addToSchePicker.dataSource = self
//        self.addToSchePicker.delegate = self
        comp = loadTerms(start_year: GloVar.start_year)
//        addToSchePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
//        addToSchePicker.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 500.0).isActive = true
        // Do any additional setup after loading the view.
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        courseDict = GloVar.courseDict
        if course_name != "" {
            self.course = courseDict[course_name]!
        }
        print("check in did load")
        if !course.inScheduler {
            addButton.backgroundColor = UIColor(displayP3Red: 5/255, green: 194/255, blue: 200/255, alpha: 1)
        } else {
            addButton.backgroundColor = UIColor.red
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        preTableView.frame = CGRect(x: preTableView.frame.origin.x, y: preTableView.frame.origin.y, width: preTableView.frame.size.width, height: preTableView.contentSize.height)
        //preTableView.reloadData()
        //self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.viewDidLoad()
//        tableView.reloadDate()
//        if check_pre_filled(node: course) {
//            fillLabel.text = "Fullfilled"
//            fillLabel.
//        } else {
//            fillLabel.text = "Unfullfilled"
//            fillLabel.textColor = UIColor.red
//        }
        print("check in did appear")
    }
    
    override func viewDidLayoutSubviews() {
        preTableView.frame = CGRect(x: preTableView.frame.origin.x, y: preTableView.frame.origin.y, width: preTableView.frame.size.width, height: preTableView.contentSize.height)
        preTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
//    @IBAction func cancel(_ sender: UIBarButtonItem) {
//        dismiss(animated: true, completion: nil)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
//        guard let button = sender as? UIBarButtonItem, button === saveButton else {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//            return
//        }
        guard let button2 = sender as? UIButton, button2 === addButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        //course.inScheduler = !course.inScheduler
        
    }


}
extension PageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func pickUp(_ textField : UITextField){
//        // UIPickerView
//        textField.inputView = addToSchePicker
//
//    }
    //  set up pickers
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return comp[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return comp[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            term = comp[component][row]
        } else {
            year = comp[component][row]
        }
        chooseTerm.text = term + " " + year
        chooseTerm.resignFirstResponder()
        //saveButton.isEnabled = true
//        addButton.isEnabled = true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        pickUp(chooseTerm)
//    }
    
    
}

extension PageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return course.all_pre.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? PreReqTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreReqTableViewCell", for: indexPath) as! PreReqTableViewCell
//        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableView.tableHeaderView?.backgroundColor = UIColor.lightGray
        return "One of the following"
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.lightGray
//
//        let headerLabel = UILabel(frame: <#T##CGRect#>)
//        headerLabel.font = UIFont(name: "Helvetica", size: 16)
//        headerLabel.textColor = UIColor.white
//        headerLabel.text = "One of the following"//tableView(tableView, titleForHeaderInSection: section)
//        headerLabel.sizeToFit()
//        headerView.addSubview(headerLabel)
//
//        return headerView
//    }
}

extension PageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return course.all_pre[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreCollectionViewCell",
                                                      for: indexPath as IndexPath) as! PreCollectionViewCell
        cell.preCourse.text = course.all_pre[collectionView.tag][indexPath.item]
        //print(cell.preCourse.text!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier:"PageViewController") as! PageViewController
        let course_name = course.all_pre[collectionView.tag][indexPath.item]
        // TODO: Can not reload dictionary every time !!!
        
        if courseDict[course_name] != nil {
            desVC.course = courseDict[course_name]!
            self.navigationController?.pushViewController(desVC, animated: true)
        }
    }
    
    
}


// #8ace5c green: 138, 206, 92
// add button #05c2c8 red: 255, 79, 79, 1
