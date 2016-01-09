//
//  RecordedAudio.swift
//  Pitch Perfect2
//
//  Created by David Miller on 1/4/16.
//  Copyright © 2016 David Miller. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String) {
        
        self.title = title
        self.filePathUrl = filePathUrl
        
    }

    
}
