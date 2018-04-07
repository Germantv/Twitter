//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by German Flores on 4/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetLabel.text = tweet.text
        userName.text = tweet.user.name
        handle.text = tweet.user.screenName
        createdAt.text = tweet.createdAtString
        
        retweetCount.text = String(tweet.retweetCount)
        favCount.text = String(tweet.favoriteCount)
        profileImage.layer.cornerRadius = 60
        profileImage.clipsToBounds = true
        profileImage.af_setImage(withURL: tweet.user.profileImage!)
        
        if tweet.favorited! {
            favButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
        }
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
        }
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetCount.text = String(tweet.retweetCount)
            
            (sender as! UIButton).setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweetCount.text = String(tweet.retweetCount)
            
            (sender as! UIButton).setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
            
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if tweet.favorited! == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
            favCount.text = String(tweet.favoriteCount)
            
            (sender as! UIButton).setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            favCount.text = String(tweet.favoriteCount)
            
            
            (sender as! UIButton).setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
            
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            print("About to reply")
            
            let replyViewController = segue.destination as! ReplyViewController
            replyViewController.tweet = tweet
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
