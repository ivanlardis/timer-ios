//
//  Prefs.swift
//  timer
//
//  Created by Иван Lardis on 29.05.18.
//  Copyright © 2018 ivanlarin. All rights reserved.
//

import Foundation


enum Prefs: String {

    case PREPARATION_TIME = "PREPARATION_TIME"
    case WORK_TIME = "WORK_TIME"
    case REST_TIME = "REST_TIME"
    case CYCLE_COUNT = "CYCLE_COUNT"
    case SET_COUNT = "SET_COUNT"
    case REST_BETWEEN_SETS_COUNT = "REST_BETWEEN_SETS_COUNT"

    case MAC_ADDRESS = "MAC_ADDRESS";

    static var userDefault: UserDefaults!
   static func initVar(){
        userDefault = UserDefaults.init()
        
        
    }
    
    static func setInt(pref: Prefs,value:Int) -> Void{
        userDefault.set(value, forKey: pref.rawValue)
    }
    
    static func getInt(pref: Prefs) -> Int {
        var min = 0
        
        switch pref {
        case PREPARATION_TIME:
            min = 0
            break
        case WORK_TIME:
            min=1
            break
        case CYCLE_COUNT:
            min=1
            break
        case REST_TIME:
            min=1
            break
        case SET_COUNT:
            min=1
            break
        default:
            break
            
        }
        
        
        if( userDefault.integer(forKey: pref.rawValue) < min){
            return min
        }
        else {
            return userDefault.integer(forKey: pref.rawValue)}

    }
    
    
  


}
