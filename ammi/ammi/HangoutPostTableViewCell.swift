//
//  HangoutPostTableViewCell.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/9/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit

class HangoutPostTableViewCell: UITableViewCell {

    @IBOutlet weak var ammiName: UILabel!
    @IBOutlet weak var purposeOfAmmi: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var numGoing: UILabel!
    @IBOutlet weak var goingImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
