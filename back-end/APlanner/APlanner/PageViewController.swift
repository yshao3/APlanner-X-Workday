//
//  PageViewController.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

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
    
    var course = loadPage()
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
