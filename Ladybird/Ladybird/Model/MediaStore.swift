//
//  MediaStore.swift
//  Worm
//
//  Created by 谭凯文 on 2018/4/5.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import Foundation

class MediaStore {
    
    
    
    var allMedias: [Media]
    
    
    init() {
        allMedias = []
    }
    
    init(doubanID: Int, mediaType: MediaType) throws {
        

        
        allMedias = try mediaType.getMedias(from: doubanID)
        
        
    }
}


