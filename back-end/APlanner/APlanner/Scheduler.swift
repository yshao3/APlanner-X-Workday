//
//  Scheduler.swift
//  APlanner
//
//  Created by MLyu on 2018/4/9.
//  Copyright © 2018 Team-I. All rights reserved.
//
import UIKit
import Foundation
//import CSV
import os.log


func build_graph(courseDict: [String: Node]) -> [String: Node] {
    //var res: Array<Node> = []
    for (_, course) in courseDict {
        if course.notCurrent_set.count != 0 {
            for cc in course.notCurrent_set {
                course.notCurrent.append(courseDict[String(cc)]!)
            }
        }
        if course.pre_set.count > 0 {
            for pre in course.pre_set {
                if let c = courseDict[pre] {
                    course.pre.append(c)
                    course.inDegree += 1
                    c.next.append(course)
                } else {
                    print(pre)
                }
            }
        }
    }
    return courseDict
}

func topology_sort(course_list: Array<Node>) -> Array<Node> {
    var res: Array<Node> = []
    var queue: Deque<Node> = Deque<Node>(100)
    for course in course_list {
        if course.inDegree == 0 {
            queue.enqueue(course)
        }
    }
    while queue.count != 0 {
        let node = queue.dequeue()
        res.append(node!)
        for next_course in (node?.next)! {
            next_course.inDegree -= 1
            next_course.level = max(next_course.level, (node?.level)! + 1)
            if next_course.notCurrent.count != 0 {
                for cc in next_course.notCurrent {
                    if cc.level == next_course.level {
                        cc.level += 1
                    }
                }
            }
            if next_course.inDegree == 0 {
                queue.enqueue(next_course)
            }
        }
    }
    return res
}

func assignSemester(course_list: Array<Node>, start_year: Int, start_term: String) -> [Int: Semester] {
    var semDict = [Int: Semester]()
    var dict = [Int: String]()
    var flag: Int
    if start_term == "Spring" {
        dict = [0: "Spring", 1: "Fall"]
    } else {
        dict = [0: "Fall", 1: "Spring"]
    }
    if start_term == "Fall" {
        flag = 1
    } else {
        flag = 0
    }
    for c in course_list {
        c.inScheduler = true
        if semDict[c.level] == nil {
            let sth = c.level + flag
            let year = start_year + sth/2
            let str = dict[c.level % 2]! + " \(year)"
            semDict[c.level] = Semester(time: str, courses: [])
        }
        semDict[c.level]?.addCourse(course: c)
    }
    return semDict
}

func determSemester(start_year: Int, start_term: String, cur_year: String, cur_term: String) -> Int {
    var start = Double(start_year)
    if start_term == "Fall" {
        start += 0.5
    }
    var cur = Double(cur_year)
    if cur_term == "Fall" {
        cur = cur! + 0.5
    }
    return Int((cur! - start) * 2.0)
    
}

func addToSemester(cur_year: String, cur_term: String) -> Int {
    return determSemester(start_year: 2017, start_term: "Fall", cur_year: cur_year, cur_term: cur_term)
}

func load_course() -> [String: Node] {
    //let d = "..."
    let raw_data = loadJson(filename: "data")
    //print(raw_data)
    var courseDict = [String: Node]()
    for str_array in raw_data! {
        let node = Node(course: str_array[0].uppercased(), title: str_array[1], desc: str_array[2], term: str_array[3], area: str_array[4], pre_str: str_array[5].uppercased(), notCurrent_str: str_array[6].uppercased(), inScheduler: false, credits: Int(str_array[8])!, tracks: str_array[7], addFrom: "")
        //course_list.append(node)
        node.after_init()
        courseDict[str_array[0].uppercased()] = node
    }
    print(courseDict["CS 2110"]?.credits ?? 3)
    //print(courseDict["cs 4110"]?.course ?? "not found")
    return courseDict
}

//func test() -> [Int: Semester] {
//    let courseDict = load_course()
//    let course_list = Array(courseDict.values)
//    let courses = build_graph(course_list: course_list, courseDict: courseDict)
//    let res = topology_sort(course_list: courses)
//    return assignSemester(course_list: res, start_year: 2017, start_term: "Fall")
//}

func test_2() -> [Int: Semester] {
    var courseDict = load_course()
    courseDict = build_graph(courseDict: courseDict)
    let selected_courses:[Node] = [courseDict["CS 1110"]!, courseDict["CS 2110"]!, courseDict["CS 2800"]!]
    //let res = topology_sort(course_list: selected_courses)
    return assignSemester(course_list: selected_courses, start_year: 2017, start_term: "Fall")
}

func load_dict() -> [String: Node] {
    var courseDict = load_course()
    courseDict = build_graph(courseDict: courseDict)
    print("load dict")
    return courseDict
}

func saveDict_disk(courseDict dict: [String: Node]) {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dict, toFile: Node.ArchiveURL.path)
    if isSuccessfulSave {
        os_log("Dictionary successfully saved.", log: OSLog.default, type: .debug)
    } else {
        os_log("Failed to save dictionary...", log: OSLog.default, type: .error)
    }
}

func loadDict_disk() -> [String: Node]?  {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Node.ArchiveURL.path) as? [String: Node]
}

func loadJson(filename fileName: String) -> [[String]]? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
       
        let peoplesArray = try! JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: path)), options: JSONSerialization.ReadingOptions()) as? [[String]]
        return peoplesArray
    }
    return nil
    
}

func check_pre_filled(node: Node) -> Bool {
    for c in node.pre {
        if !c.inScheduler {
            return false
        }
    }
    return true
}

//loadJson(filename: "data")
//
//test()

func loadSemester() -> [Int: Semester] {
//    var res: Array<Semester> = []
//    let data = loadJson(filename: "data")
//    for (key, value) in data {
//
//    }
    return test_2()
}

func loadTerms(start_year: Int) -> [[String]]{
    var years: [String] = []
    var i = 0
    while i < 4 {
        years.append(String(start_year + i))
        i += 1
    }
    return [["Fall", "Spring"], years]
}

func loadSampleCourse() -> Node {
    return Node(course: "CS2800", title: "Discrete Structures", desc: "Covers the mathematics that underlies most of computer science. Topics include mathematical induction; logical proof; propositional and predicate calculus; combinatorics and discrete mathematics; some basic elements of basic probability theory; basic number theory; sets, functions, and relations; graphs; and finite-state machines. These topics are discussed in the context of applications to many areas of computer science, such as the RSA cryptosystem and web searching.", term: "Fall, Spring", area: "General", pre_str: "CS1110", notCurrent_str: "", inScheduler: false, credits: 3, tracks: "", addFrom: "")
}
