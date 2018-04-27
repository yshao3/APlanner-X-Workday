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
    return ["cs 4940","cs 5100"]
}
func loadTags() -> [String:[String]]{
    return ["Machine Learning":["Data Science","AI"],"System":["Distributed System","Operating System","BB", "CC", "DD"]]
}
func loadImage() -> [String:[UIImage]]{
    return ["Machine Learning":[#imageLiteral(resourceName: "Plan"),#imageLiteral(resourceName: "Plan")],"System":[#imageLiteral(resourceName: "Plan"),#imageLiteral(resourceName: "Plan"),#imageLiteral(resourceName: "Plan"),#imageLiteral(resourceName: "Plan"), #imageLiteral(resourceName: "Plan")]]
}

