//
//  HistoryPresenter.swift
//  timer
//
//  Created by Иван Lardis on 02.08.18.
//  Copyright © 2018 ivanlarin. All rights reserved.
//
 
import RealmSwift
import  Alamofire

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
        
        
       getDataNW{hisList in
            
               print(hisList.count)
        
        }
    
        
            
        
            
            
        
    
    }
    func getDataNW(completion: @escaping ([HistoryModel]) -> Void) {
        
        
        
        var list = [HistoryModel]()
        let url = URL(string: "https://timerble-8665b.firebaseio.com/messages.json")
        
        Alamofire.request(url!,
                          method: .get)
            .responseJSON { response in
                if let value = response.result.value  as? [String: AnyObject] {
                    
                    print("111 \(value.count)")
                    value.forEach{ (key,valuesss) in
                      
                        
                        
                        if let item = valuesss as? [String: AnyObject] {
                            
                            var  historyModel = HistoryModel.init()
                            historyModel.cycleCount = item["cycleCount"] as! Int
                            historyModel.restTime = item["restTime"] as! Int
                            historyModel.setCount = item["setCount"] as! Int
                            historyModel.workTime = item["workTime"] as! Int
                            historyModel.time = item["time"] as! Int64
                            historyModel.name = item["name"] as! String
                            print("list apend")
                            list.append(historyModel)
                           
                        }
                        
                    }
                    
                }
                completion(list)
                return
        }
        
    
    }
    
    
    
    
}


class HistoryModel: Object {
 
    @objc dynamic var cycleCount: Int = 0
    @objc dynamic var restTime: Int = 0
     @objc dynamic var setCount: Int = 0
    
    @objc dynamic var workTime: Int = 0
    @objc dynamic var time: Int64 = 0
    @objc dynamic var name: String = ""
    
    
}
