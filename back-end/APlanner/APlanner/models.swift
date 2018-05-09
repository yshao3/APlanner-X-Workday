//
//  models.swift
//  APlanner
//
//  Created by Yijun Shao on 5/7/18.
//  Copyright © 2018 Team-I. All rights reserved.
//

import Foundation
struct GloVar {
    static var courseDict: [String: Node] = [:]//load_dict()
    static var scheduler: [Int: Semester] = [:]
    static var start_year: Int = Int()
    static var start_term: String = ""
}

//func init_scheduler() {
//    var i = 0
//    var res: [Int: Semester] = [:]
//    while (i < 8) {
//        res[i] = Semester(time: <#T##String#>, courses: [])
//    }
//}

func convert_float_to_time(time: Float) -> String {
    let year = String(Int(time))
    var term = "Sprint"
    if time - Float(Int(time)) > 0.1 {
        term = "Fall"
    }
    return term + " " + year
}

func convert_time_to_float(year: Int, term: String) -> Float {
    var now = Float(year)
    if term == "Fall" {
        now += 0.5
    }
    return now
}



