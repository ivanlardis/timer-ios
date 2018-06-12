//
//  TimerViewControler.swift
//  timer
//
//  Created by Иван Lardis on 12.06.18.
//  Copyright © 2018 ivanlarin. All rights reserved.
//

import UIKit



class TimerViewControler: UIViewController, ITimerView {
  
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
     @IBOutlet weak var cycleLabel: UILabel!
    
    
//
    func showData(timerModel:TimerModel) -> Void{

        setLabel.text="\(timerModel.setCount)"
        
        typeLabel.text="\(timerModel.type)"

        timeLabel.text="\(timerModel.time)"

        cycleLabel.text="\(timerModel.cycleCount)"


    }
 
    @IBAction func start(_ sender: Any) {
        presenter?.start()
    }
    
    
    @IBAction func stop(_ sender: Any) {
          presenter?.stop()
    }
   
    var presenter : TimerPresenter?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          presenter = TimerPresenter.init(iTimerView: self)
 
    }
 
    
    
    
}

