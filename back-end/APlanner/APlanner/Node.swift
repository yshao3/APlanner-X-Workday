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
    var pre_str: Set<String>
    var notCurrent_str: Set<String>
    var all_pre: Array<Array<String>>
    
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
        self.all_pre = []
        self.pre_str = clean_pre(pre_str: pre_str)
        self.notCurrent_str = clean_pre(pre_str: notCurrent_str)
        self.all_pre = load_all_pre(pre_str: pre_str)
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
