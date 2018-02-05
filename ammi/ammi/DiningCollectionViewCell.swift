//
//  DiningCollectionViewCell.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 8/27/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import Firebase

class DiningCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var mealType: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var numberOfPeople: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var nuGoing: UILabel!
    
    
    @IBOutlet weak var cancelOut: UIButton!
    @IBOutlet weak var goingOut: UIButton!
    
    var postID: String!
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    @IBAction func goingIsPressed(_ sender: Any) {
        
        self.goingOut.isEnabled = false
        let databaseRef = Database.database().reference()
        
        let keyToPost = databaseRef.child("dinning_posts").childByAutoId().key
        
        databaseRef.child("dinning_posts").child(self.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let post = snapshot.value as? [String : AnyObject] {
                let updateGoing: [String : Any] = ["peopleGoing/\(keyToPost)" : Auth.auth().currentUser!.uid]
                databaseRef.child("dinning_posts").child(self.postID).updateChildValues(updateGoing, withCompletionBlock: { (error, reff) in
                    
                    if error == nil {
                        databaseRef.child("dinning_posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                            if let properties = snap.value as? [String : AnyObject] {
                                if let going = properties["peopleGoing"] as? [String : AnyObject]{
                                    let count = going.count
                                    
                                    let counts = "\(count)"
                                    self.nuGoing.text = counts
                                    print(counts)
                                    
                                    let update = ["noGoing" : String(count)]
                                    databaseRef.child("dinning_posts").child(self.postID).updateChildValues(update)
                                    
                                    self.goingOut.isHidden = true
                                    self.cancelOut.isHidden = false
                                    self.goingOut.isEnabled = true
                                self.collectionview.reloadData()
                                                                    }
                                
                            }
                            
                        }
                        )
                    }
                })
            }})
        databaseRef.removeAllObservers()
        
    }
    
    
    @IBAction func cancelIsPressed(_ sender: Any) {
        goingOut.isHidden = false
    }
    
    
    
    
    
    
    
    
}
