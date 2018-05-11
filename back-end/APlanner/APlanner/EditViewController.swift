//
//  EditViewController.swift
//  APlanner
//
//  Created by Yijun Shao on 5/2/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var Enrollment: UITextField!
    @IBOutlet weak var Degree: UITextField!
    @IBOutlet weak var Major: UITextField!
    @IBOutlet weak var Semester: UITextField!
    
    @IBOutlet weak var save: UIButton!

    @IBAction func next(_ sender: Any) {
        
        if (Degree.text != "" && Enrollment.text != "" && Semester.text != "" && Major.text != ""){
            let user = User(EnrollYear: Enrollment.text!,Major: Major.text!,degree: Degree.text!,interest: NSMutableSet(),class_selected: NSMutableSet(),Semester: Semester.text!)
            let encoded: Data = NSKeyedArchiver.archivedData(withRootObject: user)
            UserDefaults.standard.set(encoded,forKey:"profile")
            UserDefaults.standard.synchronize()
            GloVar.start_year = Int(Enrollment.text!)!
            GloVar.start_term = Semester.text!
            print ("finished")
            }
        
            _ = navigationController?.popViewController(animated: true)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        //        guard let button = sender as? UIBarButtonItem, button === saveButton else {
        //            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
        //            return
        //        }
        guard let button2 = sender as? UIButton, button2 === save else {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
    }}

   var pickerview = UIPickerView()
    
    
    var Degrees:[String] = ["Bachelor", "Master", "PhD"]
    var Majors:[String]! = loadMajor()
    var semester:[String] = ["Fall","Spring"]
    var years:[String]=[]
    var cur_array:[String]=[]
    var active_textFeild: UITextField!
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
        save.isHidden = false
        active_textFeild.resignFirstResponder()
//        save.isEnabled = true
        
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
        print (cur_array)
        pickerview.isHidden = false
        save.isHidden = true
        
//        save.isEnabled = false
        pickerview.reloadAllComponents()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("I'm here")
        pickerview.isHidden = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 5/255, green: 194/255, blue: 200/255, alpha: 1)
        tabBarController?.tabBar.isHidden = true
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        for i in year-5 ... year{
            years.append(String(i))
        }
        let node:Data = UserDefaults.standard.object(forKey: "profile") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: node) as! User
        self.Semester.delegate = self;
        self.Major.delegate = self;
        self.Enrollment.delegate = self;
        self.Degree.delegate = self;
        self.pickerview.delegate = self;
        self.pickerview.dataSource = self;
        self.Semester.text = user.Semester;
        self.Degree.text = user.degree;
        self.Major.text = user.Major
        self.Enrollment.text = user.EnrollYear
        self.Semester.inputView = pickerview;
        self.Major.inputView = pickerview;
        self.Enrollment.inputView = pickerview;
        self.Degree.inputView = pickerview;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
     
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor.clear
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
