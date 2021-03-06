//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            username.text = tweet.user.name
            handle.text = tweet.user.screenName
            date.text = tweet.createdAtString
            
            retweetCount.text = String(tweet.retweetCount)
            favCount.text = String(describing: tweet.favoriteCount)
            
            profileImage.af_setImage(withURL: tweet.user.profileImage!)
            
            if tweet.favorited! {
                favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            }
            if tweet.retweeted {
                retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            }
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
    @IBAction func onFav(_ sender: Any) {
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 30
        profileImage.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
