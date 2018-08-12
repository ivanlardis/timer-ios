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
    @IBOutlet weak var customView: UIView!
    
//
    func showData(timerModel:TimerModel) -> Void{

        setLabel.text="сет \(timerModel.setCount)"
        
        typeLabel.text="\(timerModel.type.rawValue)"

        timeLabel.text="\(timerModel.time)"

        cycleLabel.text="цикл \(timerModel.cycleCount)"

       let percent = Double(1) - Double(timerModel.time) / Double(timerModel.maxTime)
        drawCustomView(percent:   percent)
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
        
        print("TimerViewControler viewDidLoad")
          presenter = TimerPresenter.init(iTimerView: self)
 
        drawCustomView(percent: 100)
        
      
    }
    
      let shapeLayer = CAShapeLayer()
    func drawCustomView(percent:Double){
        shapeLayer.removeFromSuperlayer()
        print(percent)
        var angle = (-Double.pi/2
            - 0.000001 + (Double.pi * 2) * percent   )
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(95),
                                      startAngle: CGFloat(-Double.pi/2 ),
                                      endAngle:CGFloat(angle),
                                      clockwise: true)
        
      
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.blue.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 4.0
        customView.layer.addSublayer(shapeLayer)
        
        
    }
 
    
    
    
}

