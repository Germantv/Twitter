//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by German Flores on 4/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerImageView.af_setImage(withURL: (User.current?.banner_url)!)
        profileImageView.af_setImage(withURL: (User.current?.profileImage)!)
        profileImageView.layer.cornerRadius = 60
        profileImageView.clipsToBounds = true
        nameLabel.text = User.current?.name
        screenNameLabel.text = User.current?.screenName
        bioLabel.text = User.current?.description
        followingCountLabel.text = String(describing: User.current!.following!)
        followersCountLabel.text = String(describing: User.current!.followers!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
