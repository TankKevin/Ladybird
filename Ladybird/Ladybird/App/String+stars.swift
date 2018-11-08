//
//  String+stars.swift
//  Worm
//
//  Created by 谭凯文 on 2018/4/11.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import Foundation

extension String {
    init(stars: Int) {
        switch stars {
        case 0:
            self = ""
        case 1:
            self = "★"
        case 2:
            self = "★★"
        case 3:
            self = "★★★"
        case 4:
            self = "★★★★"
        case 5:
            self = "★★★★★"
        default:
            fatalError()
        }
    }
}
