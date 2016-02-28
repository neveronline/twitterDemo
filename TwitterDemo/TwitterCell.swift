//
//  TwitterCell.swift
//  TwitterDemo
//
//  Created by Jun Hao on 2/28/16.
//  Copyright © 2016 Jun Hao. All rights reserved.
//

import UIKit
import AFNetworking

class TwitterCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var user: User!
    {
        didSet
        {
            usernameLabel.text = user.name as String?
            profileImage.setImageWithURL(user.profileUrl!)
            
        }
    }
    
    var tweet :Tweet!
        {
            didSet
            {
                let dateFormatter = NSDateFormatter()
                dateFormatter.timeStyle = .MediumStyle
                timeLabel.text = dateFormatter.stringFromDate(tweet.timestamp!)
                tweetLabel.text = tweet.text as? String
                
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        profileImage.layer.cornerRadius = 3
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
