//
//  Node.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit
import Foundation

class Node: NSObject, NSCoding {
    var course: String
    var title: String
    var pre: [Node] //???
    var inDegree: Int
    var next: Array<Node>
    var isValid: Bool
    var InvalidInfo: String
    var desc: String
    var term: String
    var area: String
    var notCurrent: Array<Node>
    var level: Int
    var pre_set: Set<String>
    var notCurrent_set: Set<String>
    var all_pre: Array<Array<String>>
    var pre_str: String
    var notCurrent_str: String
    var inScheduler: Bool
    var credits: Int
    var tracks: String
    var addFrom: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("nodes")
    
    //MARK: Types
    struct PropertyKey {
        static let course = "course"
        static let title = "title"
        static let desc = "desc"
        static let term = "term"
        static let area = "area"
        static let pre_str = "pre_str"
        static let notCurrent_str = "notCurrent_str"
        static let inScheduler = "inScheduler"
        static let credits = "credits"
//        static let pre = "pre"
        static let tracks = "tracks"
        static let addFrom = "addFrom"
    }
    
    init(course: String, title: String, desc: String, term: String, area: String, pre_str: String, notCurrent_str: String, inScheduler: Bool, credits: Int, tracks: String, addFrom: String) {
        self.course = course
        self.title = title
        self.pre = []
        self.inDegree = 0
        self.next = []
        self.isValid = true
        self.InvalidInfo = "Is valid"
        self.desc = desc
        self.term = term
        self.area = area
        self.notCurrent = []
        self.level = 0
        self.pre_str = pre_str//clean_pre(pre_str: pre_str)
        self.notCurrent_str = notCurrent_str//clean_pre(pre_str: notCurrent_str)
        self.all_pre = []
        self.pre_set = []
        self.notCurrent_set = []
        self.inScheduler = inScheduler
        self.credits = credits
        self.tracks = tracks
        self.addFrom = addFrom
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(course, forKey: PropertyKey.course)
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(desc, forKey: PropertyKey.desc)
        aCoder.encode(term, forKey: PropertyKey.term)
        aCoder.encode(area, forKey: PropertyKey.area)
        aCoder.encode(pre_str, forKey: PropertyKey.pre_str)
        aCoder.encode(notCurrent_str, forKey: PropertyKey.notCurrent_str)
        aCoder.encode(inScheduler, forKey: PropertyKey.inScheduler)
        aCoder.encode(credits, forKey: PropertyKey.credits)
//        //aCoder.encode(pre, forKey: PropertyKey.pre)
//        aCoder.encode(NSKeyedArchiver.archivedData(withRootObject: pre), forKey: PropertyKey.pre)
        aCoder.encode(tracks, forKey: PropertyKey.tracks)
        aCoder.encode(addFrom, forKey: PropertyKey.addFrom)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        let course = aDecoder.decodeObject(forKey: PropertyKey.course) as? String
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String
        
        let desc = aDecoder.decodeObject(forKey: PropertyKey.desc) as? String
        
        let term = aDecoder.decodeObject(forKey: PropertyKey.term) as? String
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let area = aDecoder.decodeObject(forKey: PropertyKey.area) as? String
        
        let pre_str = aDecoder.decodeObject(forKey: PropertyKey.pre_str) as? String
        
        let notCurrent_str = aDecoder.decodeObject(forKey: PropertyKey.notCurrent_str) as? String
        
        let inScheduler = aDecoder.decodeBool(forKey: PropertyKey.inScheduler)
        
        let credits = aDecoder.decodeInteger(forKey: PropertyKey.credits)
        
        let tracks = aDecoder.decodeObject(forKey: PropertyKey.tracks) as? String
        
        let addFrom = aDecoder.decodeObject(forKey: PropertyKey.addFrom) as? String
        
        // let pre = aDecoder.decodeObject(forKey: PropertyKey.pre) as? [Node]
        
//        let pre = NSKeyedUnarchiver.unarchiveObject(with: (aDecoder.decodeObject(forKey: PropertyKey.pre) as! NSData) as Data) as? [Node]
        
        // Must call designated initializer.
        self.init(course: course!, title: title!, desc: desc!, term: term!, area: area!, pre_str: pre_str!, notCurrent_str: notCurrent_str!, inScheduler: inScheduler, credits: credits, tracks: tracks!, addFrom: addFrom!)
    }
    
    public func after_init() {
        self.pre_set = self.clean_pre(pre_str: self.pre_str)
        self.notCurrent_set = self.clean_pre(pre_str: self.notCurrent_str)
        self.all_pre = self.load_all_pre(pre_str: self.pre_str)
    }
    //[CS2110;CS2800;CS3110,CS3111]
    private func clean_pre(pre_str: String) -> Set<String> {
        var pre_set: Set<String> = []
        let array_pre = pre_str.split(separator: ";")
        for c in array_pre {
            let str_c = String(c)
            let c_array = str_c.split(separator: ",")
            if c_array.count >= 1 {
                pre_set.insert(String(c_array[0]))
            }
        }
        return pre_set
    }
    
    private func load_all_pre(pre_str: String) -> Array<Array<String>> {
        var pre_set: Array<Array<String>> = []
        let array_pre = pre_str.split(separator: ";")
        for c in array_pre {
            var arr_pre:[String] = []
            let str_c = String(c)
            let c_array = str_c.split(separator: ",")
            if c_array.count >= 1 {
                for cc in c_array {
                    arr_pre.append(String(cc))
                }
                pre_set.append(arr_pre)
            }
        }
        return pre_set
        
    }
    
    public func setInScheduler(inScheduler: Bool) {
        self.inScheduler = inScheduler
    }
    
    public func setPre(pre: Array<Node>) {
        self.pre = pre
    }
    
    override public var hashValue: Int {
        return course.hashValue
    }
    
    public static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.course == rhs.course
    }
    
    public func setInvalidInfo(invalid: String) {
        self.InvalidInfo = invalid
    }
    
    public func setNext(next: Array<Node>) {
        self.next = next
    }
    
}
