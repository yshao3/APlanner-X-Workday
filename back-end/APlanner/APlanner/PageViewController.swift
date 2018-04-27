//
//  PageViewController.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit
import os.log

class PageViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var preLabel: UILabel!
    @IBOutlet weak var fillLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var addToSchePicker: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var preTableView: UITableView!
    @IBOutlet weak var addToPlanner: UILabel!
    @IBOutlet weak var chooseTerm: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var course = loadSampleCourse()
    var term = "Fall"
    var year = "2017"

    var comp: [[String]] = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        numLabel.text = course.course
        titleLabel.text = course.title
        descLabel.text = course.desc
        termLabel.text = course.term
        whenLabel.text = "Availabe"
        preLabel.text = "Pre-requisite"
        fillLabel.text = "Filled"
        areaLabel.text = "Academic Area"
        tagLabel.text = course.area
        addToPlanner.text = "Add to planner"
        
        //addToSchePicker.isHidden = false
        //scrollView.addSubview(addToSchePicker)
        addToSchePicker.delegate = self
        addToSchePicker.dataSource = self
        
        chooseTerm.delegate = self
        
        preTableView.delegate = self
        preTableView.dataSource = self
        
        saveButton.isEnabled = false
        
        preTableView.tableFooterView = UIView(frame: .zero)
        //scrollView.addSubview(preTableView)
        view.addSubview(scrollView)
//        stackView.addSubview(addToSchePicker)
//        self.addToSchePicker.dataSource = self
//        self.addToSchePicker.delegate = self
        comp = loadTerms(start_year: 2017)
//        addToSchePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
//        addToSchePicker.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 500.0).isActive = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        preTableView.frame = CGRect(x: preTableView.frame.origin.x, y: preTableView.frame.origin.y, width: preTableView.frame.size.width, height: preTableView.contentSize.height)
        //preTableView.reloadData()
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
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }

}
extension PageViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func pickUp(_ textField : UITextField){
        // UIPickerView
        textField.inputView = addToSchePicker
        
    }
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
        saveButton.isEnabled = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickUp(chooseTerm)
    }
    
    
}

extension PageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return course.all_pre.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreReqTableViewCell", for: indexPath) as! PreReqTableViewCell
        if course.all_pre.count > 0 {
            if course.all_pre[indexPath.section].count > 2 {
                cell.preLabel_3.text = course.all_pre[indexPath.section][2]
            } else {
                cell.preLabel_3.isHidden = true
            }
            
            if course.all_pre[indexPath.section].count > 1 {
                cell.preLabel_2.text = course.all_pre[indexPath.section][1]
            } else {
                cell.preLabel_2.isHidden = true
            }
                
            if course.all_pre[indexPath.section].count > 0 {
                cell.preLabel_1.text = course.all_pre[indexPath.section][0]
            } else {
                cell.preLabel_1.isHidden = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "one of the following"
    }
}
