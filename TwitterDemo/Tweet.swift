//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Jun Hao on 2/25/16.
//  Copyright © 2016 Jun Hao. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text : NSString?
    var timestamp : NSDate?
    var retweet_Count : Int = 0
    var favorites_Count: Int = 0

    
    
    init(dictionary: NSDictionary)
    {
        text = dictionary["text"] as? String
        retweet_Count = (dictionary["retweet_Count"] as? Int) ?? 0
        favorites_Count = (dictionary["favourites_Count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        
        if let timeStampString = timeStampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timeStampString)
            
            
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]
    {
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
            
        }
        
        return tweets
    }
    
}
