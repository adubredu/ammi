//
//  EventTableViewCell.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 9/1/17.
//  Copyright © 2017 ammi team. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    

   
    @IBOutlet weak var ammi_name: UILabel!
    @IBOutlet weak var ammi_purpose: UILabel!
    @IBOutlet weak var num_going: UILabel!
    
    @IBOutlet weak var author_image: UIImageView!
    @IBOutlet weak var ammi_time: UILabel!
    @IBOutlet weak var ammi_date: UILabel!
    
      @IBOutlet weak var tableview: UITableView!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
