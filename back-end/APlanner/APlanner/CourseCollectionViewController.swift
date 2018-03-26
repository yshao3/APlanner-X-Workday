//
//  CourseCollectionViewController.swift
//  APlanner
//
//  Created by MLyu on 22/03/2018.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CourseCollectionViewCell"

class CourseCollectionViewController: UICollectionViewController {
    var courses = [Course]()
    //MARK: Private Methods
    //let reuseIdentifier = "CourseCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = true

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        loadSampleCourses()
        self.collectionView!.register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //loadSampleCourses()
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return courses.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        //let reuseIdentifier = "CourseCollectionViewCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CourseCollectionViewCell  else {
            fatalError("The dequeued cell is not an instance of CourseCollectionViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let course = courses[indexPath.row]
        //print(cell.numberLabel.text)
        cell.backgroundColor = UIColor.red
        cell.numberLabel.text = course.number
        cell.titleLabel.text = course.title
        
        //cell.CourseNameButton.title = course.title
        return cell
    }
    
    private func loadSampleCourses() {
        
        guard let course1 = Course.init(number: "CS2110", title: "Object Oriented Programming and Data Structures") else {
            fatalError("Unable to instantiate course1")
        }
        
        guard let course2 = Course.init(number: "CS3410", title: "Computer System Organization and Programming") else {
            fatalError("Unable to instantiate course2")
        }
        
        guard let course3 = Course.init(number: "CS4410", title: "Operating Systems") else {
            fatalError("Unable to instantiate course3")
        }

        courses += [course1, course2, course3]
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
