//
//  ProfileController.swift
//  APlanner
//
//  Created by Yijun Shao on 4/18/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var DegreeMajor: UILabel!
    @IBOutlet weak var Enrollment: UILabel!
    @IBOutlet weak var Credicts: UILabel!
    

    @IBOutlet weak var tableview: UITableView!
    var tracks :[String] = ["Data Science", "Machine Learning"]
    var credits: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let node:Data = UserDefaults.standard.object(forKey: "profile") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: node) as! User
        
        DegreeMajor.text = user.degree + " of "+user.Major
        Enrollment.text = "Class of " + user.EnrollYear
        (tracks, credits) =  gettrack()
        tracks = ["Data Science", "Machine Learning"]
//    self.navigationController?. = true;
        Credicts.text = String(credits)
        self.tableview.separatorStyle = .none
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
      
        // Do any additional setup after loading the view.
    }
//    @IBAction func unwindToScheduler(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? PageViewController {
//            
//        }
//    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tracks",
                                                 for: indexPath) as! ProfileTableViewCell
        cell.track.text = tracks[indexPath.row]
        
        return cell
    }
//    func taken_credits(user: User) -> Int{
////        var credits = 0
//        return user.class_selected.count
//    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    self.navigationController?.isNavigationBarHidden = false;

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
