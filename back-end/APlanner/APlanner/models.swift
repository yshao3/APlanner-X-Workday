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
    var term = "Spring"
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

func check_model_key() {
    var i = 0
    let t = convert_time_to_float(year: GloVar.start_year, term: GloVar.start_term)
    if GloVar.scheduler.count == 0 {
        return
    }
    let keys = Array(GloVar.scheduler.keys)
    let max_key = keys.max()!
    while i < max_key {
        if GloVar.scheduler[i] == nil {
            let curT = convert_float_to_time(time: t + Float(i)/2.0)
            GloVar.scheduler[i] = Semester(time:(curT),courses:[])
        }
        i += 1
    }
}


