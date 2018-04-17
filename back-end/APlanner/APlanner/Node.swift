//
//  Node.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit
import Foundation

class Node {
    var course: String
    var title: String
    var pre: Array<Node>
    var inDegree: Int
    var next: Array<Node>
    var isValid: Bool
    var InvalidInfo: String
    var desc: String
    var term: String
    var area: String
    var notCurrent: Array<Node>
    var level: Int
    var pre_str: Set<Substring>
    var notCurrent_str: Set<Substring>
    
    init(course: String, title: String, desc: String, term: String, area: String, pre_str: String, notCurrent_str: String) {
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
        self.pre_str = []//clean_pre(pre_str: pre_str)
        self.notCurrent_str = []//clean_pre(pre_str: notCurrent_str)
        self.pre_str = clean_pre(pre_str: pre_str)
        self.notCurrent_str = clean_pre(pre_str: notCurrent_str)
    }
    //[CS2110;CS2800;CS3110,CS3111]
    private func clean_pre(pre_str: String) -> Set<Substring> {
        var pre_set: Set<Substring> = []
        let array_pre = pre_str.split(separator: ";")
        if array_pre.count != 0 {
            for c in array_pre {
                let c_array = c.split(separator: ",")
                if c_array.count >= 1 {
                    pre_set.insert(c_array[0])
                }
            }
        }
        return pre_set
    }
    
    public func setPre(pre: Array<Node>) {
        self.pre = pre
    }
    
    public var hashValue: Int {
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
