//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by German Flores on 4/6/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var replyText: UITextView!
    @IBOutlet weak var charCount: UILabel!
    
    var tweet: Tweet!
    
    @IBAction func onReply(_ sender: Any) {
        var replyTweet: [String: Any] = [:]
        
        replyTweet["text"] = self.replyText.text! + "@" + tweet.user.screenName
        replyTweet["id"] = tweet.id
        print(tweet.id)
        
        
        APIManager.shared.reply(with: replyTweet) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Reply Tweet Success!")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        replyText.delegate = self
        replyText.isEditable = true
        replyText.layer.borderWidth = 5.0
        replyText.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        replyText.layer.cornerRadius = 5
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        charCount.text = String(characterLimit - newText.characters.count)
        
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
