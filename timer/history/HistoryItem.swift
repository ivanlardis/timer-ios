//
//  HistoryItem.swift
//  timer
//
//  Created by Иван Lardis on 08.08.18.
//  Copyright © 2018 ivanlarin. All rights reserved.
//

import UIKit
class HistoryItem: UITableViewCell {
    @IBOutlet weak  var name :UILabel!
    
    @IBOutlet weak  var cycleCount :UILabel!
    
    @IBOutlet weak  var setCount :UILabel!
    
    @IBOutlet weak  var restTime :UILabel!
    
    @IBOutlet weak  var workTime :UILabel!
    
    @IBOutlet weak  var time :UILabel!
    
    func configurate(historyModel:HistoryModel){
        name.text=historyModel.name
         cycleCount.text="Циклы \(historyModel.cycleCount)"
       setCount.text="Сеты \(historyModel.setCount)"
        restTime.text="Отдых \(historyModel.restTime)"
        workTime.text="Работа \(historyModel.workTime)"
        time.text="Время \(historyModel.time)"
        
    }
}