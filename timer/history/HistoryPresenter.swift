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
    var historyRep:HistoryRep
    
    
    
    init(iTimerView: HistoryViewControler) {
        self.iTimerView = iTimerView
        self.historyRep = HistoryRep.init()
    }

    
    func getData(){
        print("getData")
        let dataDB =  self.historyRep.getDataDB();
       
         print("dataDB \( dataDB.count)")
        iTimerView.show(models:   dataDB)
      
        
        dataDB.forEach { (model) in
            self.historyRep.saveDataNW(product: model)
        }
        
        
//
//
       self.historyRep.getDataNW{hisList in
        hisList.forEach({ (model) in
               self.historyRep.saveToDB(historyModel: model)
            }
        )

        print("getDataNW \( hisList.count)")
        let dataDB1 =  self.historyRep.getDataDB();

        print("dataDB1 \( dataDB1.count)")
       self.iTimerView.show(models:  dataDB1)
        
        }
        
        
     
        
            
        
            
            
        
    
    }

}


class HistoryModel: Object, Encodable {
 
    @objc dynamic var cycleCount: Int = 0
    @objc dynamic var restTime: Int = 0
     @objc dynamic var setCount: Int = 0
    
    @objc dynamic var workTime: Int = 0
    @objc dynamic var time: Int64 = 0
    @objc dynamic var name: String = ""
    override class func primaryKey() -> String? {
        return "time"
    }
    
}

class HistoryRep {
    
    
    
    
    func saveToDB(historyModel:HistoryModel){
        let realm = try! Realm()
        try! realm.write {
            realm.add(historyModel, update: true)
        }
        
    }
    func getDataDB() -> [HistoryModel] {
        var list = [HistoryModel]()
        
        let realm = try! Realm()
        let historyModels = realm.objects(HistoryModel.self)
        historyModels.forEach{model in
            
            list.append(model)
        }
        return list
        
    }
    
    
    func saveDataNW(product: HistoryModel) {
        
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(product)
        
        let url = URL(string:"https://timerble-8665b.firebaseio.com/messages/\(product.time).json")
        
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON { response in
            
            print ("finish")
            
            
        }
    }
    
    
    
    func getDataNW(completion: @escaping ([HistoryModel]) -> Void) {
        
        
        
        var list = [HistoryModel]()
        let url = URL(string: "https://timerble-8665b.firebaseio.com/messages.json")
        
        Alamofire.request(url!,
                          method: .get)
            .responseJSON { response in
                if let value = response.result.value  as? [String: AnyObject] {
                    
                    value.forEach{ (key,valuesss) in
                        
                        
                        
                        if let item = valuesss as? [String: AnyObject] {
                            
                            var  historyModel = HistoryModel.init()
                            historyModel.cycleCount = item["cycleCount"] as! Int
                            historyModel.restTime = item["restTime"] as! Int
                            historyModel.setCount = item["setCount"] as! Int
                            historyModel.workTime = item["workTime"] as! Int
                            historyModel.time = item["time"] as! Int64
                            historyModel.name = item["name"] as! String
                            
                            list.append(historyModel)
                            
                        }
                        
                        
                    }
                    
                }
                
                completion(list)
                return
        }
        
        
    }
    
    
    
    
}
