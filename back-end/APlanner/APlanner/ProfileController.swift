//
//  ProfileController.swift
//  APlanner
//
//  Created by Yijun Shao on 4/18/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var DegreeMajor: UILabel!
    @IBOutlet weak var Enrollment: UILabel!
    @IBOutlet weak var Credicts: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let node:Data = UserDefaults.standard.object(forKey: "profile") as! Data
        print (node)
        let user = NSKeyedUnarchiver.unarchiveObject(with: node) as! User
        
        DegreeMajor.text = user.degree + " of "+user.Major
        Enrollment.text = "Class of " + user.EnrollYear
        Credicts.text = String(taken_credits(user: user))
        
        // Do any additional setup after loading the view.
    }
    func taken_credits(user: User) -> Int{
        //        var credits = 0
        return user.class_selected.count
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
