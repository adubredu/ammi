//
//  dinning.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 7/18/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class dinning: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var breakfastButtonOut: UIButton!
    @IBOutlet weak var lunchButtonOut: UIButton!
    @IBOutlet weak var dinnerButtonOut: UIButton!
    @IBOutlet weak var dateAndTime: UIDatePicker!
    
    @IBAction func breakfastButtonIsPressed(_ sender: Any) {
        lunchButtonOut.isHidden = true
        dinnerButtonOut.isHidden = true
        
    }
    
    @IBAction func lunchButtonIsPresed(_ sender: Any) {
        breakfastButtonOut.isHidden = true
        dinnerButtonOut.isHidden = true
    }
    
    @IBAction func dinnerButtonIsPressed(_ sender: Any) {
        breakfastButtonOut.isHidden = true
        lunchButtonOut.isHidden = true
    }
   
    
    
    
    @IBOutlet weak var dewickOut: UIButton!
    @IBOutlet weak var carmOut: UIButton!
    @IBOutlet weak var campusCenterOut: UIButton!
    @IBOutlet weak var brownBrewOut: UIButton!
    @IBOutlet weak var davisOut: UIButton!
    @IBOutlet weak var maxPeople: UITextField!
    let databaseRef = Database.database().reference()
    
    //let userID = "WZvvyBy4YGMpI04pAbTnOQgjhnK2"
    
    @IBAction func dewickIsPressed(_ sender: Any) {
        carmOut.isHidden = true
        campusCenterOut.isHidden = true
        brownBrewOut.isHidden = true
        davisOut.isHidden = true
    }
    
    
    @IBAction func carmIsPressed(_ sender: Any) {
        dewickOut.isHidden = true
        campusCenterOut.isHidden = true
        brownBrewOut.isHidden = true
        davisOut.isHidden = true

    }
    
    @IBAction func campusCenterIsPressed(_ sender: Any) {
        carmOut.isHidden = true
        dewickOut.isHidden = true
        brownBrewOut.isHidden = true
        davisOut.isHidden = true

    }
    
    
    @IBAction func brownBrewIsPressed(_ sender: Any) {
        carmOut.isHidden = true
        campusCenterOut.isHidden = true
        dewickOut.isHidden = true
        davisOut.isHidden = true

    }
    
    @IBAction func davisIsPressed(_ sender: Any) {
        carmOut.isHidden = true
        campusCenterOut.isHidden = true
        brownBrewOut.isHidden = true
        dewickOut.isHidden = true

    }
    
    
    
    @IBAction func cancelIsPressed(_ sender: Any) {
        breakfastButtonOut.isHidden = false
        lunchButtonOut.isHidden = false
        dinnerButtonOut.isHidden = false
        carmOut.isHidden = false
        campusCenterOut.isHidden = false
        brownBrewOut.isHidden = false
        davisOut.isHidden = false
        dewickOut.isHidden = false
        maxPeople.text = " "

    }
   
    
    
    @IBAction func findIsPressed(_ sender: Any) {
        var meal = "none"
        var location = "none"
        
        //meal selection
        
        if (breakfastButtonOut.isHidden == false && lunchButtonOut.isHidden == true && dinnerButtonOut.isHidden == true) {
             meal = "Breakfast"
        }
        else if (lunchButtonOut.isHidden == false && breakfastButtonOut.isHidden == true && dinnerButtonOut.isHidden == true){
            meal = "Lunch"
       }
        else if (dinnerButtonOut.isHidden == false && breakfastButtonOut.isHidden == true && lunchButtonOut.isHidden == true) {
            meal = "Dinner"
        }
        
 
        
        //location selection
        
        
        if (carmOut.isHidden == false && campusCenterOut.isHidden == true && brownBrewOut.isHidden == true && davisOut.isHidden == true && dewickOut.isHidden == true) {
            location = "Carmichael Hall"
        }
        else if (carmOut.isHidden == true && campusCenterOut.isHidden == false && brownBrewOut.isHidden == true && davisOut.isHidden == true && dewickOut.isHidden == true){
            location = "Campus Center"
        }
        else if (carmOut.isHidden == true && campusCenterOut.isHidden == true && brownBrewOut.isHidden == false && davisOut.isHidden == true && dewickOut.isHidden == true) {
            location = "Brown and Brew"
        }
        else if (carmOut.isHidden == true && campusCenterOut.isHidden == true && brownBrewOut.isHidden == true && davisOut.isHidden == false && dewickOut.isHidden == true) {
            location = "Davis Square"
        }
        else if (carmOut.isHidden == true && campusCenterOut.isHidden == true && brownBrewOut.isHidden == true && davisOut.isHidden == true && dewickOut.isHidden == false) {
            location = "Dewick Dining Hall"
        }
        
        
        //warnings
        if (location == "none" && meal != "none") {
            let alertController = UIAlertController(title: "Alert", message:
                "Select a location", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else if (meal == "none" && location != "none") {
            let alertController = UIAlertController(title: "Alert", message:
                "Select a meal", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else if (meal == "none" && location == "none") {
            let alertController = UIAlertController(title: "Alert", message:
                "Select a meal and a location", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
      
        
        
        if (meal != "none" && location != "none"){
            
            let userID = Auth.auth().currentUser!.uid
            databaseRef.child("user_profile").child(userID).observe(.value, with: { (snapshot:DataSnapshot) in
                
                //create a dictionary of user's profile data
                let values = snapshot.value as? NSDictionary
                
                //uses ammi-self appointed profile pic
                //let profileImageURL = (values?["profile_pic"] as? String)!
                
                
                let profile_pic = Auth.auth().currentUser?.photoURL?.absoluteString
                let people = self.maxPeople.text
                
                let period = self.dateAndTime.date.description
                
                
                let key = self.databaseRef.child("dinning_posts").childByAutoId().key
                let newValuesForProfile =
                    ["meal": meal,
                     "userID" : userID,
                     "profile_pic": profile_pic!,
                     "author": Auth.auth().currentUser?.displayName! as Any,
                     "location": location,
                     "noGoing": "0",
                     "postID":key,
                     "max_people": people!,
                     "time": period] as [String : Any]
                
                let postFeed = ["\(key)" : newValuesForProfile]
                
                self.databaseRef.child("dinning_posts").updateChildValues(postFeed)
            })
            
                /*{
                    
                    let databaseProfilePic = values?["profile_pic"]as? String
                    let data = NSData(contentsOf: NSURL(string: databaseProfilePic!) as! URL)
                    self.setProfilePicture(imageView: self.profilePicture, imageToSet: UIImage(data: data! as Data)!)
                    //
                }
                
            }
            )*/
        
        
            
            //uses facebook pic
           // let profile_pic = Auth.auth().currentUser?.photoURL?.absoluteString
            
            
           
            let alertController = UIAlertController(title: "Confirmation", message:
                "Your dining invitation has been posted publicly", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)

            
            
        }
      
        }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        FBSDKLoginManager().logOut()
        //performsegue
        performSegue(withIdentifier: "loggedOut", sender: self)
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: "opened")
        
        //change to false
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
