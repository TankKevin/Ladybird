//
//  Movie.swift
//  Worm
//
//  Created by 谭凯文 on 2018/4/3.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import Foundation

class Media {
    var name: String {
        didSet {
            // 修复错误：将可能存在的“&#39;”替换为“'”
            var str = name
            if let range = str.range(of: "&#39;") {
                str.replaceSubrange(range, with: "'")
            }
            name = str
            
        }
    }
    var date: String
    var star: String
    var comment: String
    
    init() {
        name = ""
        date = ""
        star = ""
        comment = ""
    }
    
    init(name: String, date: String, star: String, comment: String) {
        self.name = name
        
        self.date = date
        self.star = star
        self.comment = comment
        
    }
}
