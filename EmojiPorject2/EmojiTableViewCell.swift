//
//  EmojiTableViewCell.swift
//  EmojiPorject2
//
//  Created by Ilya Sokolov on 26.05.2022.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    // создаю связи с лайблами на маинсториборд 
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func set(object: Emoji) {
        
        self.emojiLabel.text = object.emoji
        self.nameLable.text = object.name
        self.descriptionLabel.text = object.description
        
        
        
        
    }
}
