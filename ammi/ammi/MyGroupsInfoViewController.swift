//
//  MyGroupsInfoViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/17/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class MyGroupsInfoViewController: UIViewController {

    
    
    @IBOutlet weak var groupName: UILabel!
    
    
    @IBOutlet weak var dateOfMeeting: UILabel!
    @IBOutlet weak var timeOfMeeting: UILabel!
    @IBOutlet weak var VenueOfMeeting: UILabel!
    @IBOutlet weak var addressOfVenue: UILabel!
    @IBOutlet weak var numGoing: UILabel!
    @IBOutlet weak var purposeOfGroup: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var maxNumPeople: UILabel!
    
    var nameofgroup = String()
    var meetingdate = String()
    var meetingtime = String()
    var meetingvenue = String()
    var meetingaddress = String()
    var authorname = String()
    var numbergoing = String()
    var grouppurpose = String()
    var groupdescription = String()
    var maximum = String()
    var postID = String()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        groupName.text = nameofgroup
        dateOfMeeting.text = meetingdate
        timeOfMeeting.text = meetingtime
        VenueOfMeeting.text = "Venue:  \(meetingvenue)"
        addressOfVenue.text = "Address: \(meetingaddress)"
        numGoing.text = "\(numbergoing) people going"
        purposeOfGroup.text = grouppurpose
        groupDescription.text = groupdescription
        maxNumPeople.text = maximum
    }
    

    @IBAction func backIsPressed(_ sender: Any)
    {
        performSegue(withIdentifier: "backToMyGroups", sender: self)
    }
    
    @IBAction func didPressDelete(_ sender: Any)
    {
        let ref = Database.database().reference()
        ref.child("Posts").child(postID).removeValue()        
        performSegue(withIdentifier: "backToMyGroups", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
