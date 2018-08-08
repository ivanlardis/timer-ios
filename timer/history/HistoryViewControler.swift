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
    var data=[HistoryModel.init()]
   
    var presenter : HistoryPresenter?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HistoryViewControler viewDidLoad")
        presenter = HistoryPresenter.init(iTimerView:self)
        
        presenter?.getData()
       
    }
    
    
    func show(models:[HistoryModel]){
        
        data = models;
        self.tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        // set the text from the data model
        guard let historyCell = cell as? HistoryItem else {
            return cell
        }
      historyCell.configurate(historyModel: self.data[indexPath.row])
        
        return historyCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
   
   
    
    
}

