//
//  constants.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/14/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
//

import Foundation

var todoList:[String]?
var account: [String]?

func saveData(todoList: [String], accountList: [String]){
    UserDefaults.standard.set(todoList, forKey: "list")
    UserDefaults.standard.set(accountList, forKey: "alist")

}

//func saveData1(accountList: [String])

func fetchData1() ->[String]?{
    if let atodo = UserDefaults.standard.array(forKey: "alist") as? [String]{
        return atodo
    }
    else{
        return nil
    }
}


func fetchData() -> [String]?{
    if let todo = UserDefaults.standard.array(forKey: "list") as? [String]{
        return todo
    }
    else{
        return nil
    }
}
