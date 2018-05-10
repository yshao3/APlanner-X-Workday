//
//  LoginViewController.swift
//  APlanner
//
//  Created by Yijun Shao on 4/18/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,
UITextFieldDelegate{
    
    @IBOutlet weak var Degree: UITextField!
    @IBOutlet weak var Enrollment: UITextField!
    @IBOutlet weak var Semester: UITextField!
    @IBOutlet weak var Major: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func Next(_ sender: Any) {
        if (Degree.text != "Degree" && Enrollment.text != "Enrollment Year" && Semester.text != "Semester" && Major.text != "Major"){
            let user = User(EnrollYear: Enrollment.text!,Major: Major.text!,degree: Degree.text!, interest: NSMutableSet(),class_selected: NSMutableSet(),Semester: Semester.text!)
        
            let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: user)
            UserDefaults.standard.set(encoded,forKey:"profile")
            UserDefaults.standard.synchronize()
            
            print ("finished")
            //            UserDefaults.standard.set([Enrollment.text, Major.text, Degree.text, Semester.text], forKey: "profile")
            GloVar.start_year = Int(Enrollment.text!)!
            GloVar.start_term = Semester.text!
            
        } else {
            let user = User(EnrollYear: "2017",Major: "Computer Science", degree: "Bachelor", interest: NSMutableSet(),class_selected: NSMutableSet(),Semester: "Fall")
            
            let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: user)
            UserDefaults.standard.set(encoded,forKey:"profile")
            UserDefaults.standard.synchronize()
            GloVar.start_year = 2017
            GloVar.start_term = "Fall"
        }
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        var tab = segue.destination as!ProfileController
    //        tab.user = User(EnrollYear: Enrollment.text!,Major: Major.text!,degree: Degree.text!, Semester: Semester.text!)
    //    }
    //    var pickerView = UIPickerView()
    //    var Degrees:[String]! = loadDegree()
    var Degrees:[String] = ["Bachelor", "Master"]
    var Majors:[String]! = loadMajor()
    var semester:[String] = ["Fall","Spring"]
    var years:[String]=[]
    var cur_array:[String]=[]
    var active_textFeild: UITextField!
    var pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.isHidden = true
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        for i in year-5 ... year+5{
            years.append(String(i))
        }
        startButton.backgroundColor = UIColor(displayP3Red: 5/255, green: 194/255, blue: 200/255, alpha: 1)
        GloVar.courseDict = load_dict()
        GloVar.start_year = 2017
        GloVar.start_term = "Fall"
        //
        pickerView.dataSource = self
        pickerView.delegate = self
        Degree.inputView = pickerView
        Semester.inputView = pickerView
        Major.inputView = pickerView
        Enrollment.inputView = pickerView
        
        
        //        Degree.delegate = self
        //        Semester.delegate = self
        //        Major.delegate = self
        //        Enrollment.delegate = self
        
        
        //        view.addSubview(DegreePicker)
        
        // Do any additional setup after loading the view.
    }
    //  set up pickers
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cur_array[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cur_array.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        active_textFeild.text = cur_array[row]
        pickerView.isHidden = true
        active_textFeild.resignFirstResponder()
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        active_textFeild = textField
        switch textField{
        case Degree:
            cur_array = Degrees
        case Major:
            cur_array = Majors
        case Enrollment:
            cur_array = years
        case Semester:
            cur_array = semester
        default:
            print ("Some errors")
        }
        pickerView.isHidden = false
        print(cur_array)
        pickerView.reloadAllComponents()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
