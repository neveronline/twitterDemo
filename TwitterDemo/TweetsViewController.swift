//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Jun Hao on 2/25/16.
//  Copyright © 2016 Jun Hao. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var tweets : [Tweet]!
    var userlogin : User!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            
            
            for tweet in tweets{
                print(tweet.timestamp)
            }
            
            },failure:  { (error:NSError) -> () in
                print(error.localizedDescription)
                
        })
        
        TwitterClient.sharedInstance.currentAcount({ (userlogin: User) -> () in
            
            self.userlogin = userlogin
            
            self.tableView.reloadData()
            }) { (error:NSError) -> () in
                print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnLogoutButton(sender: AnyObject)
    {
        TwitterClient.sharedInstance.logout()     
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tweets != nil
        {
            return tweets!.count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TwitterCell", forIndexPath: indexPath) as! TwitterCell
        
        cell.tweet = tweets[indexPath.row]
        cell.user = userlogin
        
        
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
