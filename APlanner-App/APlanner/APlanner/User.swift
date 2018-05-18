//
//  User.swift
//  APlanner
//
//  Created by Yijun Shao on 4/18/18.
//  Copyright © 2018 Team-I. All rights reserved.
//
import UIKit
import Foundation

class User:NSObject,NSCoding{
    
    var EnrollYear: String
    var class_selected: NSMutableSet
    var degree: String
    var Major: String
    var interests: NSMutableSet
    var Semester: String
    
    init(EnrollYear: String, Major: String, degree: String, interest: NSMutableSet , class_selected:NSMutableSet,Semester: String){
        self.EnrollYear = EnrollYear
        self.Major = Major
        self.degree = degree
        self.Semester = Semester
        self.class_selected = class_selected
        self.interests = interest
        
    }
    public func add_class(course: Node){
        self.class_selected.add(course)
    }
    public func delet_class(course: Node){
        self.class_selected.remove(course)
    }
    public func add_interest(interest: String){
        self.interests.add(interest)
    }
    public func delet_interest(interest: String){
        self.interests.remove(interest)
    }
    required convenience init(coder aDecoder: NSCoder) {
        
        let enroll = aDecoder.decodeObject(forKey:"EnrollYear") as! String
        let class_selected = aDecoder.decodeObject(forKey: "class_selected") as! NSMutableSet
        let degree = aDecoder.decodeObject(forKey: "degree") as! String
        let  semester = aDecoder.decodeObject(forKey: "Semester") as! String
        let  major = aDecoder.decodeObject(forKey: "major") as! String
        let intestes = aDecoder.decodeObject(forKey: "interests") as! NSMutableSet
        self.init(EnrollYear: enroll,Major: major,degree: degree, interest: intestes, class_selected: class_selected,Semester: semester)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(EnrollYear, forKey: "EnrollYear")
        aCoder.encode(class_selected, forKey: "class_selected")
        aCoder.encode(Semester, forKey: "Semester")
        aCoder.encode(Major, forKey: "major")
        aCoder.encode(interests, forKey:"interests")
        aCoder.encode(degree, forKey:"degree")
    }
}
