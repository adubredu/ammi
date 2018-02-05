//
//  MyGroupsTableViewCell.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/14/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class MyGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var ammiName: UILabel!
    @IBOutlet weak var purposeOfAmmi: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var numGoing: UILabel!
    @IBOutlet weak var goingImage: UIImageView!
    
    var postID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func deleteIsPressed(_ sender: Any)
    {
        let databaseRef = Database.database().reference()
        databaseRef.child("Posts").child(self.postID).removeValue()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
