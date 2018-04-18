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
    @IBOutlet weak var DegreePicker: UIPickerView!

    let Degrees = ["Bacholar", "Master"]
    //  set up pickers
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Degrees[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Degrees.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Degree.text = Degrees[row]
        DegreePicker.isHidden = true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (DegreePicker.isHidden){
            print("here")
            DegreePicker.isHidden = false
        }
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DegreePicker.isHidden = true
        view.addSubview(DegreePicker)

        // Do any additional setup after loading the view.
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
