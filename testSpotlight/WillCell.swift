//
//  WillCell.swift
//  testSpotlight
//
//  Created by William Wong on 15/12/2015.
//  Copyright © 2015 Fleetmatics. All rights reserved.
//

import UIKit

class WillCell: UITableViewCell {
    
    @IBOutlet weak var imageCorner: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
