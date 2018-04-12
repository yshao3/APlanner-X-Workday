//
//  Scheduler.swift
//  APlanner
//
//  Created by MLyu on 2018/4/9.
//  Copyright © 2018 Team-I. All rights reserved.
//
import UIKit

class Semester {
    var time: String
    var courses: Array<Node>
    
    init(time: String, courses: Array<Node>) {
        self.time = time
        self.courses = courses
    }
    
    public func count() -> Int {
        return courses.count
    }
}

func build_graph(course_list: Array<Node>) -> Array<Node> {
    //var res: Array<Node> = []
    for course in course_list {
        for pre in course.pre {
            course.inDegree += 1
            pre.next.append(course)
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
            if next_course.inDegree == 0 {
                queue.enqueue(next_course)
            }
        }
    }
    return res
}


func test() -> Array<Semester>{
    var course_list: Array<Node> = []
    //let d = "..."
    let d = "CS 4410 covers systems programming and introductory operating system design and implementation. We will cover the basics of operating systems, namely structure, concurrency, scheduling, synchronization, memory management, filesystems, security and networking. CS 4410 covers systems programming and introductory operating system design and implementation. We will cover the basics of operating systems, namely structure, concurrency, scheduling, synchronization, memory management, filesystems, security and networking. CS 4410 covers systems programming and introductory operating system design and implementation. We will cover the basics of operating systems, namely structure, concurrency, scheduling, synchronization, memory management, filesystems, security and networking. "
    let A = Node(course: "A", title: "Operating Systems", desc: d, term: "Fall, Spring", area: "Core, System")
    let B = Node(course: "B", title: "Operating Systems", desc: d, term: "Fall, Spring", area: "Core, System")
    let C = Node(course: "C", title: "Operating Systems", desc: d, term: "Fall, Spring", area: "Core, System")
    let D = Node(course: "D", title: "Operating Systems", desc: d, term: "Fall, Spring", area: "Core, System")
    let E = Node(course: "E", title: "Operating Systems", desc: d, term: "Fall, Spring", area: "Core, System")
    course_list.append(A)
    course_list.append(B)
    course_list.append(C)
    course_list.append(D)
    course_list.append(E)
    let courses = build_graph(course_list: course_list)
//    for c in courses {
//        print(c.course, c.inDegree)
//    }
    let res = topology_sort(course_list: courses)
//    for c in res {
//        print(c.course)
//    }
    let s1 = Semester(time: "Fall 2017", courses: [res[0]])
    let s2 = Semester(time: "Spring 2018", courses: [res[1], res[2]])
    let s3 = Semester(time: "Fall 2017", courses: [res[3], res[4]])
    let sem = [s1, s2, s3, s2, s3, s2, s3]
    return sem
}
func loadPage() -> Node {

    let course = Node(course: "CS4110", title: "Operating Systems", desc: "sdff", term: "Fall, Spring", area: "Core, System")
    return course
}

func loadJson(filename fileName: String) -> Data? {
    //    print ("there")
    do {
        if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                // json is a dictionary
                print(object)
            } else if let object = json as? [Any] {
                // json is an array
                print(object)
            } else {
                print("JSON is invalid")
            }
            return data
        } else {
            print("no file")
        }
    } catch {
        print(error.localizedDescription)
    }
    return nil
}
//loadJson(filename: "data")
//test()

func loadSemester() -> Array<Semester>{
//    var res: Array<Semester> = []
//    let data = loadJson(filename: "data")
//    for (key, value) in data {
//
//    }
    return test()
}
