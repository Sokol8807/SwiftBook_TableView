//
//  EmojiTableViewController.swift
//  EmojiPorject2
//
//  Created by Ilya Sokolov on 26.05.2022.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    
    
    var objects = [
    
        Emoji(emoji: "🥰", name: "Love", description: "Love is love", isFavourite: false),
        Emoji(emoji: "⚽️", name: "Football", description: "Let's play footbal together", isFavourite: false),
        Emoji(emoji: "🐱", name: "Cat", description: "Cut is a cute animal", isFavourite: false)

    ]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emoji Reader"
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue ) {
        
        guard segue.identifier == "saveSegue" else {return}
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        
        if let selectredIndexPath = tableView.indexPathForSelectedRow {
            
            objects[selectredIndexPath.row] = emoji
            tableView.reloadRows(at: [selectredIndexPath], with: .fade)
        
        }
        else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            
            objects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigaionVC = segue.destination as! UINavigationController
        let newEmojiVC = navigaionVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        
        
            cell.emojiLabel.text = "🤣"
       let object = objects[indexPath.row]
        cell.set(object: object)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {


            return .delete

        }
        

    override func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath ) {
        if editingStyle == .delete {
            
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        
        }
}
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
        
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favoriteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        
        return action
        
    }
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") {(action, view, completion)
            in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
            
        }
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
