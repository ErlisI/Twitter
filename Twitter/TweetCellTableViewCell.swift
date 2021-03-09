//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Erlis Ibraimi on 2.3.21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    
    
    @IBAction func likeTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setfavorited(true)
            }, failure: { (Error) in
                print("Liked did not succeed: \(Error)")
            })
        }else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setfavorited(false)
            }, failure: { (Error) in
                print("UnLiked did not succeed: \(Error)")
            })
        }
    }
    
    @IBAction func reTweet(_ sender: Any) {
        
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error is retweeting: \(Error)")
        })
        
    }
    
    func setRetweeted(_ isReTweeted: Bool) {
        
        if(isReTweeted){
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
            
        }else {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweetButton.isEnabled = true
        }
        
    }
    
    
    func setfavorited(_ isfavorited: Bool){
        
        favorited = isfavorited
        
        if(favorited){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
