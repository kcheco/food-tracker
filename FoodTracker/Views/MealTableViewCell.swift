//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 7/2/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    /*
     ------------------------------------
     MARK: Properties
     ------------------------------------
     */
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
