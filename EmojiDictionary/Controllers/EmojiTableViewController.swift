//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Dylan Williamson on 12/20/18.
//  Copyright © 2018 Dylan Williamson. All rights reserved.
//

import UIKit
import Foundation

class EmojiTableViewController: UITableViewController {
    
    
    
    
    var emojis: [Emoji] = []
//
//    var sectionHeaders: [String] = ["Smileys and People", "Animals and Nature", "Food and Drink", "Activity, Travel, and Places", "Other Emojis"]
    
//    var smileysAndPeople: [Emoji] = [
//        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
//        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face", usage: "Unsure what to think, displeasure"),
//        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with heart for eyes", usage: "Love of something, attractive"),
//        Emoji(symbol: "👮‍♀️", name: "Police Officer", description: "A police wearing a blue cap and gold badge", usage: "Person of auhtority")
//    ]
//
//    var animalsAndNature: [Emoji] = [
//        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle", usage: "Something slow"),
//        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant", usage: "Good memory")
//    ]
//
//    var foodAndDrink: [Emoji] = [
//        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti", usage: "Spaghetti"),
//        Emoji(symbol: "🌮", name: "Taco", description: "A hard shell taco", usage: "Taco")
//    ]
//
//    var activityTravelAndPlaces: [Emoji] = [
//        Emoji(symbol: "📚", name: "Books", description: "A stack of three colored books", usage: "Studious"),
//        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent", usage: "Camping")
//    ]
//
//    var otherEmojis: [Emoji] = [
//        Emoji(symbol: "👅", name: "Tongue", description: "Tongue being show", usage: "To tease"),
//        Emoji(symbol: "🧠", name: "Brain", description: "The human brain", usage: "Shows intelligence"),
//        Emoji(symbol: "🎲", name: "Die", description: "A 6 sided die", usage: "Taking a risk, chance; game"),
//        Emoji(symbol: "💤", name: "Snore", description: "3 blue Zs", usage: "Tired, sleepiness")
//    ]
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emojis = Emoji.loadFromFile() ?? Emoji.loadSampleEmojis()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
//        emojis.append(smileysAndPeople)
//        emojis.append(animalsAndNature)
//        emojis.append(foodAndDrink)
//        emojis.append(activityTravelAndPlaces)
//        emojis.append(otherEmojis)
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return emojis.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //return emojis[section].count
        return emojis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Step 1 dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell

        // Step 2 fetch model object to display
        //let emoji = emojis[indexPath.section][indexPath.row]
        let emoji = emojis[indexPath.row]
        
        // Step 3 configure cell
        cell.update(with: emoji)
        cell.showsReorderControl = true
        
        // Step 4 return cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath,
                            to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        Emoji.saveToFile(emojis: emojis)
        tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section < sectionHeaders.count {
//            return sectionHeaders[section]
//        }
//        return nil
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Emoji.saveToFile(emojis: emojis)
        }
    }
    
    

    
     // MARK: - table view delegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //let emojiSelected = emojis[indexPath.section][indexPath.row]
//        let emojiSelected = emojis[indexPath.row]
//        print("Emoji name is \(emojiSelected.name) and the indexPath is \(indexPath)")
//    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditTableViewController = navController.topViewController as! AddEditEmojiTableViewController
            
            addEditTableViewController.emoji = emoji
        }
    }
    
    @IBAction func unwindToEmojiTableView(unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "saveUnwind" else { return }
        let sourceViewController = unwindSegue.source as! AddEditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .none)
            }
        }
        Emoji.saveToFile(emojis: emojis)
    }
    
    
}
