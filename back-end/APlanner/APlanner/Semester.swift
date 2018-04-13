//
//  Semester.swift
//  APlanner
//
//  Created by MLyu on 2018/4/13.
//  Copyright © 2018 Team-I. All rights reserved.
//

import Foundation

class Semester {
    var time: String
    var courses: Array<Node>
    
    init(time: String) {
        self.time = time
        self.courses = []
    }
    
    public func addCourse(course: Node) {
        self.courses.append(course)
    }
    
    public func count() -> Int {
        return courses.count
    }
}
