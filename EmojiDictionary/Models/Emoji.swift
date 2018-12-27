//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Dylan Williamson on 12/20/18.
//  Copyright © 2018 Dylan Williamson. All rights reserved.
//

import Foundation

struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("emojis.plist")
    
    
    
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        
        try? encodedEmojis?.write(to: archiveURL, options: .noFileProtection)
        
        
    }
    
    static func loadFromFile() -> [Emoji]? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedEmojisData = try? Data(contentsOf: archiveURL),
            let decodedEmojis = try? propertyListDecoder.decode(Array<Emoji>.self, from: retrievedEmojisData) {
            return decodedEmojis
        } else {
            return nil
        }
    }
    
    static func loadSampleEmojis() -> [Emoji] {
        let emojis: [Emoji] = [
            Emoji(symbol: "😀", name: "Grinning Face",
                  description: "A typical smiley face.", usage: "happiness"),
            Emoji(symbol: "😕", name: "Confused Face",
                  description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes",
                  description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
            Emoji(symbol: "👮", name: "Police Officer",
                  description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
            Emoji(symbol: "🐢", name: "Turtle",
                  description: "A cute turtle.", usage: "Something slow"),
            Emoji(symbol: "🐘", name: "Elephant",
                  description: "A gray elephant.", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti",
                  description: "A plate of spaghetti.", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die",
                  description: "A single die.", usage: "taking a risk, chance;"),
            Emoji(symbol: "⛺️", name: "Tent",
                  description: "A small tent.", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books",
                  description: "Three colored books stacked on each other.", usage: "homework, studying"),
            Emoji(symbol: "💔", name: "Broken Heart",
                  description: "A red, broken heart.", usage: "extreme sadness"),
            Emoji(symbol: "💤", name: "Snore",
                  description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag",
                  description: "A black-and-white checkered flag.", usage: "completion")
        ]
        
        return emojis
    }
}
