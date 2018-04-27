//
//  Semester.swift
//  APlanner
//
//  Created by MLyu on 2018/4/13.
//  Copyright © 2018 Team-I. All rights reserved.
//

import Foundation
import os.log

class Semester: NSObject, NSCoding {
    
    var time: String
    var courses: Array<Node>
    
    init(time: String) {
        self.time = time
        self.courses = []
    }
    
    //MARK: Types
    
    struct PropertyKey {
        static let time = "time"
        static let courses = "courses"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(courses, forKey: PropertyKey.courses)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let time = aDecoder.decodeObject(forKey: PropertyKey.time) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let courses = aDecoder.decodeObject(forKey: PropertyKey.courses) as? [Node] else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(time: time)

    }
    

    
    public func addCourse(course: Node) {
        self.courses.append(course)
    }
    
    public func count() -> Int {
        return courses.count
    }
}
