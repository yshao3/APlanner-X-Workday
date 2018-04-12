//
//  Course.swift
//  APlanner
//
//  Created by MLyu on 21/03/2018.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit
import os.log

class Course: NSObject, NSCoding  {
    
    //MARK: Properties
    var number: String
    var title: String
    //var pre: Array<Course>
    //var rating: Int
    
    //MARK: Types
    
    struct PropertyKey {
        static let number = "number"
        static let title = "title"
        //static let pre = "pre"
    }
    
    init?(number: String, title: String) {
        if number.isEmpty || title.isEmpty {
            return nil
        }
        self.number = number
        self.title = title
        //self.pre = pre
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(number, forKey: PropertyKey.number)
        aCoder.encode(title, forKey: PropertyKey.title)
        //aCoder.encode(pre, forKey: PropertyKey.pre)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let number = aDecoder.decodeObject(forKey: PropertyKey.number) as? String else {
            os_log("Unable to decode the name for a Course object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the name for a Course object.", log: OSLog.default, type: .debug)
            return nil
        }
        
//        guard let pre = aDecoder.decodeObject(forKey: PropertyKey.pre) as? String else {
//            os_log("Unable to decode the name for a Course object.", log: OSLog.default, type: .debug)
//            return nil
//        }
        
        // Must call designated initializer.
        self.init(number: number, title: title)
        
    }
    
    
}
