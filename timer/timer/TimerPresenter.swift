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

        for currentPreparationTime in 0...Prefs.getInt(pref: Prefs.PREPARATION_TIME) {
            list.append(TimerModel.init(type: TYPE.PREPARATION_TIME,
                    time: Prefs.getInt(pref: Prefs.PREPARATION_TIME)+1-currentPreparationTime))
        }
        
        for currentSet in 1...Prefs.getInt(pref: Prefs.SET_COUNT) {
            for currentCycle in 1...Prefs.getInt(pref: Prefs.CYCLE_COUNT) {
                
                for workTime in 1...Prefs.getInt(pref: Prefs.WORK_TIME) {
                    list.append(TimerModel.init(type: TYPE.WORK_TIME,
                                                time: Prefs.getInt(pref:  Prefs.WORK_TIME) + 1 - workTime,
                                                                   setCount: currentSet,
                                                                   cycleCount: currentCycle) )
                    
                }
                
                for restTime in 1...Prefs.getInt(pref: Prefs.REST_TIME) {
                    list.append(TimerModel.init(type: TYPE.REST_TIME,
                                                time: Prefs.getInt(pref:  Prefs.REST_TIME) + 1 - restTime,
                                                setCount: currentSet,
                                                cycleCount: currentCycle) )
                    
                }
        }
            
            for restBetweenTime in 1...Prefs.getInt(pref: Prefs.REST_BETWEEN_SETS_COUNT) {
                list.append(TimerModel.init(type: TYPE.REST_BETWEEN_SETS_COUNT,
                                            time: Prefs.getInt(pref:  Prefs.REST_BETWEEN_SETS_COUNT) + 1 - restBetweenTime,
                                            setCount: currentSet) )
                
            }
            
            
            
        }
            
        
        


        return list
    }


}

enum TYPE {
    case PREPARATION_TIME
    case WORK_TIME
    case REST_TIME
    case REST_BETWEEN_SETS_COUNT
}


class TimerModel {
    var type: TYPE
    var time: Int
    var setCount: Int
    var cycleCount: Int

    init(type: TYPE,
         time: Int,
         setCount: Int = 1,
         cycleCount: Int = 1) {

        self.type = type
        self.time = time
        self.setCount = setCount
        self.cycleCount = cycleCount

    }
}
