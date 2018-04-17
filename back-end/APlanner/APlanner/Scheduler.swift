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


func build_graph(course_list: Array<Node>, courseDict: [String: Node]) -> Array<Node> {
    //var res: Array<Node> = []
    for course in course_list {
        if course.notCurrent_str.count != 0 {
            for cc in course.notCurrent_str {
                course.notCurrent.append(courseDict[String(cc)]!)
            }
        }
        if course.pre_str.count > 0 {
            for pre in course.pre_str {
                let c = courseDict[String(pre)]
                course.inDegree += 1
                c?.next.append(course)
            }
        }
        
        //res.append(course)
    }
    return course_list
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
        if semDict[c.level] == nil {
            let sth = c.level + flag
            let year = start_year + sth/2
            let str = dict[c.level % 2]! + " \(year)"
            semDict[c.level] = Semester(time: str)
        }
        semDict[c.level]?.addCourse(course: c)
    }
    return semDict
}


func load_course() -> [String: Node] {
    //let d = "..."
    let raw_data = loadJson(filename: "data")
    //print(raw_data)
    var courseDict = [String: Node]()
    for str_array in raw_data! {
        let node = Node(course: str_array[0], title: str_array[1], desc: str_array[2], term: str_array[3], area: str_array[4], pre_str: str_array[5], notCurrent_str: str_array[6])
        //course_list.append(node)
        courseDict[str_array[0]] = node
    }

//    let A = Node(course: "CS1110", title: "Introduction to Computing Using Python", desc: "Programming and problem solving using Python. Emphasizes principles of software development, style, and testing. Topics include procedures and functions, iteration, recusion, arrays and vectors, strings, an operational model of procedure and function calls, algorithms, exceptions, object-oriented programming, and GUIs (graphical user interfaces). Weekly labs provide guided practice on the computer, with staff present to help. Assignments use graphics and GUIs to help develop fluency and understanding.", term: "Fall, Spring, Summer", area: "General", pre_str: "", notCurrent_str: "")
//    let B = Node(course: "CS2110", title: "OO Programming and Data Structures", desc: "CS 2110 (cross-listed as ENGRD 2100) is an intermediate-level programming course and an introduction to computer science. Topics include program design and development, debugging and testing, object-oriented programming, proofs of correctness, complexity analysis, recursion, commonly used data structures, trees, graph algorithms, and abstract data types. Java is the principal programming language. ", term: "Fall, Spring", area: "General", pre_str: "CS1110", notCurrent_str: "")
//    //let B = Node(course: "B", title: "Operating Systems", desc: d, term: "Fall, Spring", area: "Core, System")
//    let C = Node(course: "CS2800", title: "Discrete Structures", desc: "Covers the mathematics that underlies most of computer science. Topics include mathematical induction; logical proof; propositional and predicate calculus; combinatorics and discrete mathematics; some basic elements of basic probability theory; basic number theory; sets, functions, and relations; graphs; and finite-state machines. These topics are discussed in the context of applications to many areas of computer science, such as the RSA cryptosystem and web searching.", term: "Fall, Spring", area: "General", pre_str: "CS1110", notCurrent_str: "")
//    let D = Node(course: "CS3110", title: "Data Structures and Functional Programming", desc: "Advanced programming course that emphasizes functional programming techniques and data structures. Programming topics include recursive and higher-order procedures, models of programming language evaluation and compilation, type systems, and polymorphism. Data structures and algorithms covered include graph algorithms, balanced trees, memory heaps, and garbage collection. Also covers techniques for analyzing program performance and correctness.", term: "Fall, Spring", area: "Core", pre_str: "CS2110,CS2800", notCurrent_str: "CS3410")
//    let E = Node(course: "CS3410", title: "Computer System Organization and Programming", desc: "Introduction to computer organization, systems programming and the hardware/ software interface. Topics include instruction sets, computer arithmetic, datapath design, data formats, addressing modes, memory hierarchies including caches and virtual memory, I/O devices, bus-based I/O systems, and multicore architectures. Students learn assembly language programming and design a pipelined RISC processor.", term: "Fall, Spring", area: "Core", pre_str: "CS2110", notCurrent_str: "CS3110")
//    let F = Node(course: "CS4410", title: "Operating System", desc: "Introduction to the design of systems programs, with emphasis on multiprogrammed operating systems. Topics include concurrency, synchronization, deadlocks, memory management, protection, input-output methods, networking, file systems and security. The impact of network and distributed computing environments on operating systems is also discussed.", term: "Fall, spring, summer", area: "Core, System", pre_str: "CS3410", notCurrent_str: "")
//    let G = Node(course: "CS4820", title: "Introduction to Analysis of Algorithms", desc: "Develops techniques used in the design and analysis of algorithms, with an emphasis on problems arising in computing applications. Example applications are drawn from systems and networks, artificial intelligence, computer vision, data mining, and computational biology. This course covers four major algorithm design techniques (greedy algorithms, divide-and-conquer, dynamic programming, and network flow), undecidability and NP-completeness, and algorithmic techniques for intractable problems (including identification of structured special cases , approximation algorithms, local search heuristics, and online algorithms).", term: "Fall, spring, summer", area: "Core, System", pre_str: "CS2800,CS3110", notCurrent_str: "")
//    course_list.append(A)
//    course_list.append(B)
//    course_list.append(C)
//    course_list.append(D)
//    course_list.append(E)
//    course_list.append(F)
//    course_list.append(G)
    return courseDict
}

func test() -> [Int: Semester] {
    let courseDict = load_course()
    let course_list = Array(courseDict.values)
    let courses = build_graph(course_list: course_list, courseDict: courseDict)
    let res = topology_sort(course_list: courses)
    return assignSemester(course_list: res, start_year: 2017, start_term: "Fall")
}


func loadJson(filename fileName: String) -> [[String]]? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        let peoplesArray = try! JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: path)), options: JSONSerialization.ReadingOptions()) as? [[String]]
        return peoplesArray
    }
    return nil
    
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
    return test()
}

func loadSampleCourse() -> Node {
    return Node(course: "CS2800", title: "Discrete Structures", desc: "Covers the mathematics that underlies most of computer science. Topics include mathematical induction; logical proof; propositional and predicate calculus; combinatorics and discrete mathematics; some basic elements of basic probability theory; basic number theory; sets, functions, and relations; graphs; and finite-state machines. These topics are discussed in the context of applications to many areas of computer science, such as the RSA cryptosystem and web searching.", term: "Fall, Spring", area: "General", pre_str: "CS1110", notCurrent_str: "")
}
