//
//  TimerPresenter.swift
//  timer
//
//  Created by Иван Lardis on 12.06.18.
//  Copyright © 2018 ivanlarin. All rights reserved.
//

import Foundation
import RxSwift

class TimerPresenter {


    var iTimerView: ITimerView

    init(iTimerView: ITimerView) {
        self.iTimerView = iTimerView
    }

    var subscription: Disposable?

    public func start() -> Void {
        subscription?.dispose()
        
        var list : [TimerModel] = getListTrain()
        print(list.count)
        subscription = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
         .take(list.count)
                .subscribe { event in
                    if(  !event.isCompleted ){
                   print(event)
                    let timerModel : TimerModel = list[event.element!]
                    self.iTimerView.showData(timerModel: timerModel)
                    }
                }


    }

    public func stop() -> Void {
        subscription?.dispose()
    }

   
    
    func getListTrain() -> [TimerModel] {
        var list = [TimerModel]()

        
        
        var pres = HistoryRep.init()
        
        var hisModel=HistoryModel.init()
        hisModel.cycleCount=Prefs.getInt(pref: Prefs.CYCLE_COUNT)
        hisModel.name="IOS"
        hisModel.restTime=Prefs.getInt(pref: Prefs.REST_TIME)
        hisModel.setCount=Prefs.getInt(pref: Prefs.SET_COUNT)
        hisModel.time = Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
        hisModel.workTime=Prefs.getInt(pref: Prefs.WORK_TIME)
        pres.saveToDB(historyModel:hisModel)
        
        
        for currentPreparationTime in 0...Prefs.getInt(pref: Prefs.PREPARATION_TIME) {
            list.append(TimerModel.init(type: TYPE.PREPARATION_TIME,
                    time: Prefs.getInt(pref: Prefs.PREPARATION_TIME)+1-currentPreparationTime,
                        maxTime: Prefs.getInt(pref: Prefs.PREPARATION_TIME)))
        }
        
        for currentSet in 1...Prefs.getInt(pref: Prefs.SET_COUNT) {
            for currentCycle in 1...Prefs.getInt(pref: Prefs.CYCLE_COUNT) {
                
                for workTime in 1...Prefs.getInt(pref: Prefs.WORK_TIME) {
                    list.append(TimerModel.init(type: TYPE.WORK_TIME,
                                                time: Prefs.getInt(pref:  Prefs.WORK_TIME) + 1 - workTime,
                        maxTime: Prefs.getInt(pref:  Prefs.WORK_TIME),
                                                                   setCount: currentSet,
                                                                   cycleCount: currentCycle) )
                    
                }
                
                for restTime in 1...Prefs.getInt(pref: Prefs.REST_TIME) {
                    list.append(TimerModel.init(type: TYPE.REST_TIME,
                                                time: Prefs.getInt(pref:  Prefs.REST_TIME) + 1 - restTime,
                                                 maxTime: Prefs.getInt(pref:  Prefs.REST_TIME),
                                                setCount: currentSet,
                                                cycleCount: currentCycle) )
                    
                }
        }
            
            for restBetweenTime in 1...Prefs.getInt(pref: Prefs.REST_BETWEEN_SETS_COUNT) {
                list.append(TimerModel.init(type: TYPE.REST_BETWEEN_SETS_COUNT,
                                            time: Prefs.getInt(pref:  Prefs.REST_BETWEEN_SETS_COUNT) + 1 - restBetweenTime,
                                            maxTime: Prefs.getInt(pref:  Prefs.REST_BETWEEN_SETS_COUNT),
                                            setCount: currentSet) )
                
            }
            
            
            
        }
            
        
        


        return list
    }


}

enum TYPE : String {
    case PREPARATION_TIME="ПОДГОТОВКА"
    case WORK_TIME="РАБОТА"
    case REST_TIME="ОТДЫХ"
    case REST_BETWEEN_SETS_COUNT="ОТДЫХ МЕЖДУ ПОДХОДАМИ"
}


class TimerModel {
    var type: TYPE
    var time: Int
     var maxTime: Int
    var setCount: Int
    var cycleCount: Int

    init(type: TYPE,
         time: Int,
           maxTime: Int,
         setCount: Int = 1,
         cycleCount: Int = 1) {

        self.type = type
        self.time = time
        self.maxTime = maxTime
        self.setCount = setCount
        self.cycleCount = cycleCount

    }
}
