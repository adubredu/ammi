
//
//  LunchInfoViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/13/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class LunchInfoViewController: UIViewController {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    @IBAction func backIsPressed(_ sender: Any)
    {
        performSegue(withIdentifier: "backToLunchList", sender: self)
    }
    
    
    @IBAction func noButtonIsPressed(_ sender: Any)
    {
        let ref = Database.database().reference()
        ref.child("Posts").child(self.postID).observeSingleEvent(of: .value, with:
            { (snapshot) in
                
                if let properties = snapshot.value as? [String : AnyObject]
                {
                    if let peopleGoing = properties["peopleGoing"] as? [String : AnyObject]
                    {
                        for (id, person) in peopleGoing
                        {
                            if person as? String == self.userID
                            {
                                ref.child("Posts").child(self.postID).child("peopleGoing").child(id).removeValue(
                                    completionBlock: { (error, reff) in
                                        
                                        if error == nil
                                        {
                                            ref.child("Posts").child(self.postID).observeSingleEvent(of: .value, with:
                                                {(snap) in
                                                    if let prop = snap.value as? [String : AnyObject]
                                                    {
                                                        if let going = prop["peopleGoing"] as? [String : AnyObject]
                                                        {
                                                            let count = "\(going.count)"
                                                            self.numGoing.text = count
                                                            
                                                            ref.child("Posts").child(self.postID).updateChildValues(["noGoing" : count])
                                                        }
                                                            
                                                        else
                                                        {
                                                            self.numGoing.text = "0"
                                                            ref.child("Posts").child(self.postID).updateChildValues(["noGoing" : "0"])
                                                        }
                                                    }
                                            })
                                        }
                                        
                                })
                                break
                            }
                        }
                    }
                }
        }
        )
        
        yesButton.isHidden = false
        noButton.isHidden = true
        ref.removeAllObservers()
    }
    
    
    @IBAction func yesButtonIsPressed(_ sender: Any)
    {
        let ref = Database.database().reference()
        let autoKey = ref.child("Posts").childByAutoId().key
        
        ref.child("Posts").child(postID).observeSingleEvent(of: .value, with: {(snapshot: DataSnapshot)
            in
            
            if snapshot.hasChildren()
            {
                let updateGoing : [String : Any] = ["peopleGoing/\(autoKey)" : self.userID]
                ref.child("Posts").child(self.postID).updateChildValues(updateGoing, withCompletionBlock: { (error, reff)
                    in
                    
                    if error == nil
                    {
                        ref.child("Posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap)
                            in
                            
                            if let properties = snap.value as? [String : AnyObject]
                            {
                                if let going = properties["peopleGoing"]  as? [String : AnyObject]
                                {
                                    let count = "\(going.count)"
                                    self.numGoing.text = count
                                    
                                    let updateNum = ["noGoing" : count]
                                    ref.child("Posts").child(self.postID).updateChildValues(updateNum)
                                }
                            }
                        })
                    }
                }
                    
                )
            }
        })
        
        ref.removeAllObservers()
        
        yesButton.isHidden = true
        noButton.isHidden = false

    }
    
    @IBOutlet weak var dateOfMeeting: UILabel!
    @IBOutlet weak var timeOfMeeting: UILabel!
    @IBOutlet weak var VenueOfMeeting: UILabel!
    @IBOutlet weak var addressOfVenue: UILabel!
    @IBOutlet weak var nameOfAuthor: UILabel!
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
    
    let userID = Auth.auth().currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupName.text = nameofgroup
        dateOfMeeting.text = meetingdate
        timeOfMeeting.text = meetingtime
        VenueOfMeeting.text = meetingvenue
        addressOfVenue.text = meetingaddress
        nameOfAuthor.text = authorname
        numGoing.text = numbergoing
        purposeOfGroup.text = grouppurpose
        groupDescription.text = groupdescription
        maxNumPeople.text = maximum
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func hide_button()
    {
        let ref = Database.database().reference()
        ref.child("Posts").child(postID).child("peopleGoing").queryOrderedByKey().observe(.value, with: {(snapshot: DataSnapshot)
            in
            if snapshot.hasChildren() {
                let values = snapshot.value as! [String : AnyObject]
                
                var inthere = false
                for (_,person) in values
                {
                    if (person as! String) == self.userID
                    {
                        inthere = true
                    }
                }
                
                if inthere
                {
                    self.yesButton.isHidden = true
                    self.noButton.isHidden = false
                }
                    
                else
                {
                    self.yesButton.isHidden = false
                    self.noButton.isHidden = true
                }
            }
        })
        ref.removeAllObservers()
    }

}
