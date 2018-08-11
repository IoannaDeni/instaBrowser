//
//  DetailsViewController.swift
//  instaBrowser
//
//  Created by user143365 on 8/10/18.
//  Copyright © 2018 Ioanna Deni. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailImageView: PFImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var posts: PFObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let posts = posts{
            
            detailImageView.file = posts["media"] as? PFFile
            captionLabel.text = posts["caption"] as? String
            let name = posts["author"] as! PFUser
            nameLabel.text = name.username! + " posted a new pic:"
            
            if let postTime = posts.createdAt{
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short //medium
                dateFormatter.timeStyle = .short
                
                let timeStr = dateFormatter.string(from: postTime)
                timeLabel.text = "On " + timeStr
            }
            
            detailImageView.loadInBackground()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
