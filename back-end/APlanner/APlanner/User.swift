//
//  User.swift
//  APlanner
//
//  Created by Yijun Shao on 4/18/18.
//  Copyright © 2018 Team-I. All rights reserved.
//
import UIKit
import Foundation

class User{
    
    var EnrollYear: String
    var class_selected: NSMutableSet = NSMutableSet()
    var degree: String
    var Major: String
    var interests: Set<String> = Set()
    
    init(EnrollYear: String, Major: String, degree: String){
        self.EnrollYear = EnrollYear
        self.Major = Major
        self.degree = degree
        
    }
    public func add_class(course: Node){
        self.class_selected.add(course)
    }
    public func delet_class(course: Node){
        self.class_selected.remove(course)
    }
    public func add_interest(interest: String){
        self.interests.insert(interest)
    }
    public func delet_interest(interest: String){
        self.interests.remove(interest)
    }
}
