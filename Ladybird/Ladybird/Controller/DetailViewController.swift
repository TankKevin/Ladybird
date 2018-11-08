//
//  DetailViewController.swift
//  Worm
//
//  Created by 谭凯文 on 2018/4/8.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var tabInfo: [(String, String)]!
    
    var media: Media! {
        didSet {
            tabInfo = [("时间", "\(media.date)"), ("评分", "\(media.star)"), ("短评", "\(media.comment)") ]
            
        }
    }
    
    
    
    override func viewDidLoad() {
        
        // 让标题只含有中文名字
        if let spaceIndex = media.name.index(of: " ") {
            title = String(media.name.prefix(upTo: spaceIndex))
        } else {
            title = media.name
        }
        
        
        
        
        // 设置三行内容
        for row in 0...2 {
            // 必须先加载tableView，然后才能配置各种cell
            tableView.reloadData()
            
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0))!
            cell.textLabel?.text = tabInfo[row].0
            cell.detailTextLabel?.text = tabInfo[row].1
            
        }
        
        
        
        
    }
    

}
