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
    return ["Machine Learning":["Data Science","AI"],"System":["Distributed System","Operating System"]]
}
func loadImage(major:String) -> [String:[UIImage]]{
    return ["Machine Learning":[#imageLiteral(resourceName: "conv_art_intel"),#imageLiteral(resourceName: "data_in_eve_life")],"System":[#imageLiteral(resourceName: "dist_db"),#imageLiteral(resourceName: "sde_1")]]
}
func loadCore(track:String) -> [String]{
    return ["CS 4410","CS 4700"]
}
func loadPlan(core:[String]) -> [[String]]{
    return [["CS 1110","CS 1120"],["CS 2300","CS 2800"],["CS 3300","CS 3000"], ["CS 4410","CS 4470"]]
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
