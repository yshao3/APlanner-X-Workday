//
//  Login.swift
//  APlanner
//
//  Created by Yijun Shao on 4/19/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import Foundation
import UIKit

//load degrees
func loadDegree()->[String]{
    return ["Bacholar", "Master"]
}
func loadMajor()->[String]{
    //should connect to database here
    return ["Computer Sicence"]
}
func loadtrack(trackname:String) -> [String]{
    return ["CS 4940","CS 5100"]
}
func loadTags(major:String) -> [String:[String]]{
    return ["Artificial Intelligence":["Data Science","AI in real life"],"Cryptography":["Advanced Topics in Algorithms","Entrepreneurship in Technology"]]
}
func loadImage(major:String) -> [String:[UIImage]]{
    return ["Artificial Intelligence":[#imageLiteral(resourceName: "conv_art_intel"),#imageLiteral(resourceName: "data_in_eve_life")],"Cryptography":[#imageLiteral(resourceName: "dist_db"),#imageLiteral(resourceName: "sde_1")]]
}
func loadCore(track:String, course_dic:[String:Node]) -> [Node]{
    var res:[Node] = []
    for row in Array(course_dic){
        if (row.value.area == track){
            res.append(row.value)
        }
    }
    return res
}
func loadPlan(core:[Node],course_dic:[String:Node]) -> [[Node]]{
    var res:[[Node]] = []
    var level = 0
    var dic :Deque<Node> = Deque(100)
    for c in core{
        dic.enqueue(c)
    }
    var visited:Set<Node> = []
    while !dic.isEmpty{
        var number = dic.count
        
        while number > 0{
            let tmp = dic.dequeue()
            if (!visited.contains(tmp!)){
            res[level].append(tmp!)
                visited.insert(tmp!)
            for n in (tmp?.pre)!{
                dic.enqueue(n)
                }
            }
            number -= 1
        }
        level+=1
    }
    
    return res
}
func selectedCourse() ->  (NSMutableSet,Int){
    let map = NSKeyedUnarchiver.unarchiveObject(withFile: Semester.ArchiveURL.path) as? [Int: Semester]
    var s = NSMutableSet()
    var credits = 0
    if (map == nil){
        return (s, credits)
    }
    for item  in map!{
        let semester = item.value
        for course in semester.courses{
            s.add(course.course)
            credits += course.credits
        }
    }
    return (s, credits)
}
func gettrack() -> ([String],Int){
    let (courses,  credits) = selectedCourse()
    let tags = loadTags(major:"CS")
//    var cores :[String:[String]] = [:]
    var res:[String] = []
    for tag in tags{
        for track in tag.value{
            let cores = loadtrack(trackname: track)
            var num = 0
            for core in cores{
                if (courses.contains(core)){
                    num += 1
                }else{
                    break
                }
            }
            if (num == cores.count){
                res.append(track)
            }
        }
    }
    
    return (res, credits)
}
