//
//  Node.swift
//  APlanner
//
//  Created by MLyu on 2018/4/11.
//  Copyright © 2018 Team-I. All rights reserved.
//

import UIKit

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
    
    init(course: String, title: String, desc: String, term: String, area: String) {
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
