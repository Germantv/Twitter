//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String
    var profileImage: URL?
    var banner_url: URL
    var followers: Int?
    var following: Int?
    var location: String
    var tweets: Int?
    var description: String
    
    // For user persistance
    var dictionary: [String: Any]?
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        profileImage = URL(string: dictionary["profile_image_url_https"] as! String)
        if !(dictionary["profile_banner_url"] == nil){
            banner_url = URL(string: dictionary["profile_banner_url"] as! String)!
        }else{
            banner_url = URL(string: "nil")!
        }
        followers = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
        location = dictionary["location"] as! String
        tweets = dictionary["statuses_count"] as? Int
        description = dictionary["description"] as! String
    }
}
