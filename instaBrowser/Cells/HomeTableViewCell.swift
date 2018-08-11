//
//  HomeTableViewCell.swift
//  instaBrowser
//
//  Created by user143365 on 8/10/18.
//  Copyright © 2018 Ioanna Deni. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var imageViewLabel: PFImageView!
    var instagramPost: PFObject! {
        didSet {
            self.imageViewLabel.file = instagramPost["image"] as? PFFile
            self.imageViewLabel.loadInBackground()
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
