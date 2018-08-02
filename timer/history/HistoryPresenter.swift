//
//  HistoryPresenter.swift
//  timer
//
//  Created by Иван Lardis on 02.08.18.
//  Copyright © 2018 ivanlarin. All rights reserved.
//
 
import RealmSwift


class HistoryPresenter {
    var iTimerView: HistoryViewControler
    
    init(iTimerView: HistoryViewControler) {
        self.iTimerView = iTimerView
    }

    func save(historyModel:HistoryModel){
        let realm = try! Realm()
        try! realm.write {
            realm.add(historyModel)
        }
        
    }
    func getListTrain() -> [HistoryModel] {
        var list = [HistoryModel]()
 
        let realm = try! Realm()
        let historyModels = realm.objects(HistoryModel.self)
        historyModels.forEach{model in
            
            list.append(model)
            }
        return list
        
    }
    
    func getData(){
        var his =  HistoryModel.init()
        his.cycleCount=1
        
        save(historyModel: his)
        
        let hisList = getListTrain()
        
        print("historyModels \(hisList.count)")
    }
    
    
    
    
    
}


class HistoryModel:Object {
    
    @objc dynamic var cycleCount: Int = 0
    @objc dynamic var restTime: Int = 0
     @objc dynamic var setCount: Int = 0
    
    @objc dynamic var workTime: Int = 0
    @objc dynamic var time: Int64 = 0
    @objc dynamic var name: String = ""
    
    
}
