//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Jun Hao on 2/25/16.
//  Copyright © 2016 Jun Hao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class TwitterClient: BDBOAuth1SessionManager {
    

    
     static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "jwi133uZeZl3kMNTqbjE6RWYg", consumerSecret: "36Wx10YoZWrmrrLa2VHbdnPQ40HTCFT6n6mU0Rh0UstJujDuRX")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError)-> ())?
    
    
    
    func homeTimeline(success:([Tweet]) ->(), failure: (NSError)->()){
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
                
        })
    }
    
    func currentAcount(success: (User)->(),failure: (NSError)->()){

        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("account:\(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            
            
            }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
                
        })
    }
    func handleOpenUrl(url:NSURL)
    {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath(	"oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential!) -> Void in
            
            self.currentAcount({ (user:User) -> () in
                User.cuttrentUser = user
                self.loginSuccess?()
                }, failure: { (error:NSError) -> () in
                    self.loginFailure?(error)
            })
            
            
            
            }) { (error:NSError!) -> Void in
                print("error:\(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
    }
    func login(success: ()->(),failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            
            }) { (error: NSError!) -> Void in
                print("error:\(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    func logout()
    {
        User.cuttrentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
        
    }
}
