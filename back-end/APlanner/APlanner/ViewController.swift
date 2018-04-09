//
//  ViewController.swift
//  APlanner
//
//  Created by MLyu on 27/03/2018.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Mark Properties:
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var coursePreReq: UILabel!

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descContent: UILabel!
    @IBOutlet weak var courseTagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: Actions
    @IBAction func setPreCourseAction(_ sender: UIButton) {
        coursePreReq.text = "prerequisite courses"
    }
    
    @IBAction func tagsButton(_ sender: UIButton) {
        courseTagLabel.text = "test"
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
