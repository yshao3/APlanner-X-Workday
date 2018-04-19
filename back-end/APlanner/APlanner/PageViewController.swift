//
//  PageViewController.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
    @IBOutlet weak var stackView: UIStackView!
    
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
        
        addToSchePicker.isHidden = false
        view.addSubview(scrollView)
        scrollView.addSubview(addToSchePicker)
//        stackView.addSubview(addToSchePicker)
//        self.addToSchePicker.dataSource = self
//        self.addToSchePicker.delegate = self
        comp = loadTerms(start_year: 2017)
        addToSchePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        addToSchePicker.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 500.0).isActive = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
