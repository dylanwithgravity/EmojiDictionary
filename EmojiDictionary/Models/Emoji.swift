//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Dylan Williamson on 12/20/18.
//  Copyright © 2018 Dylan Williamson. All rights reserved.
//

import Foundation

class Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description:String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}
