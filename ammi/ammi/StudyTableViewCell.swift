//
//  StudyTableViewCell.swift
//  
//
//  Created by Alphonsus Adu-Bredu on 8/26/17.
//
//

import UIKit
import Firebase

class StudyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var max_people: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var nuGoing: UILabel!
    
    
    @IBOutlet weak var goingOut: UIButton!
    @IBOutlet weak var cancelOut: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var postID: String!
    
    
    
    
    
    
    
    
    
    
    @IBAction func goingIsPressed(_ sender: Any) {
        
        //  self.goingOut.isEnabled = false
        let databaseRef = Database.database().reference()
        
        let keyToPost = databaseRef.child("studyGroup_posts").childByAutoId().key
        
        databaseRef.child("studyGroup_posts").child(self.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let post = snapshot.value as? [String : AnyObject] {
                let updateGoing: [String : Any] = ["peopleGoing/\(keyToPost)" : Auth.auth().currentUser!.uid]
                databaseRef.child("studyGroup_posts").child(self.postID).updateChildValues(updateGoing, withCompletionBlock: { (error, reff) in
                    
                    if error == nil {
                        databaseRef.child("studyGroup_posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let going = properties["peopleGoing"] as? [String : AnyObject]{
                                    let count = going.count
                                    
                                    let counts = "\(count)"
                                    self.nuGoing.text = counts
                                    print(counts)
                                    
                                    let update = ["noGoing" : String(count)]
                                    databaseRef.child("studyGroup_posts").child(self.postID).updateChildValues(update)
                                    
                                    self.goingOut.isHidden = true
                                    self.cancelOut.isHidden = false
                                    //   self.goingOut.isEnabled = true
                                    
                                   // myvar.kan = counts
                                    //self.nuGoing.text = myvar.kan
                                }
                                
                            }
                            
                        }
                        )
                        //databaseRef.removeAllObservers()
                    }
                })
            }})
        //tableview.reloadData()
        
        databaseRef.removeAllObservers()
        tableview.reloadData()
        // nuGoing.text = myvar.kan   
    }
    
    
    
    
    
    @IBAction func cancelIsPressed(_ sender: Any) {
        
        //self.cancelOut.isEnabled = false
        let databaseRef = Database.database().reference()
        
        databaseRef.child("studyGroup_posts").child(self.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let properties = snapshot.value as? [String : AnyObject] {
                if let peopleGoing = properties["peopleGoing"] as? [String : AnyObject] {
                    for (id, person) in peopleGoing {
                        if person as? String == Auth.auth().currentUser!.uid {
                            
                            databaseRef.child("studyGroup_posts").child(self.postID).child("peopleGoing").child(id).removeValue(completionBlock: { (error, reff) in
                                if error == nil {
                                    
                                    databaseRef.child("studyGroup_posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                                        
                                        if let prop =  snap.value as? [String : AnyObject] {
                                            if let going = prop["peopleGoing"] as? [String : AnyObject] {
                                                let count = going.count
                                                self.nuGoing.text = "\(count)"
                                                databaseRef.child("studyGroup_posts").child(self.postID).updateChildValues(["noGoing" : "\(count)"])
                                            } else {
                                                self.nuGoing.text = "0"
                                                databaseRef.child("studyGroup_posts").child(self.postID).updateChildValues(["noGoing" : "0"])
                                            }
                                        }
                                    })
                                }
                            })
                            self.goingOut.isHidden = false
                            self.cancelOut.isHidden = true
                            // self.cancelOut.isEnabled = true
                            break
                            
                        }
                    }
                }
            }
            
        })
        
        databaseRef.removeAllObservers()

    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cancelOut.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
