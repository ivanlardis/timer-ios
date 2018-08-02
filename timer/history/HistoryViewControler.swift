//
//  HistoryViewControler.swift
//  timer
//
//  Created by Иван Lardis on 02.08.18.
//  Copyright © 2018 ivanlarin. All rights reserved.
//


//
// Created by Иван Lardis on 29.05.18.
// Copyright (c) 2018 ivanlarin. All rights reserved.
//

import UIKit

class HistoryViewControler: UITableViewController {
    
   
    var presenter : HistoryPresenter?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HistoryViewControler viewDidLoad")
        presenter = HistoryPresenter.init(iTimerView:self)
        
        presenter?.getData()
        
    }
   
   
    
    
}

