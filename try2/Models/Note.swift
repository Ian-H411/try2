//
//  Note.swift
//  CrushThisTestNoteApp
//
//  Created by Ian Hall on 8/2/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

class Note: Equatable, Codable{
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.text == rhs.text
        
    }
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
}

