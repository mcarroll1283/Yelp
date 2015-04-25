//
//  BusinessCell.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/23/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet {
            thumbImageView.setImageWithURL(NSURL(string: business.imageUrl))
            nameLabel.text = business.name
            distanceLabel.text = NSString(format: "%.2fmi", business.distance)
            ratingImageView.setImageWithURL(NSURL(string: business.ratingImageUrl))
            reviewCountLabel.text = NSString(format: "%d Reviews", business.numReviews)
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Rounded corners on the image
        self.thumbImageView.layer.cornerRadius = 3
        self.thumbImageView.clipsToBounds = true
        
        // XXX: May not need this. It's an autolayout bug fix discussed in the video
        //nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

// XXX: May not need this. It's an autolayout bug fix discussed in the video
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width
//    }

}
