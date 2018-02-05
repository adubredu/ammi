//
//  study.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 7/18/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import Firebase

class study: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let locations = ["Tisch Library","Campus Center","Ginn Library","Music Library", "Other"]
    
    @IBAction func chooseLoc(_ sender: Any) {
        locOptions.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseLocOut.setTitle(locations[row], for: .normal)
        locOptions.isHidden = true
    }
    
    @IBOutlet weak var dateAndTime: UIDatePicker!
       
    @IBOutlet weak var chooseLocOut: UIButton!
    @IBOutlet weak var locOptions: UIPickerView!
    @IBOutlet weak var subjectOut: UITextField!
    @IBOutlet weak var messageOut: UITextView!
    @IBOutlet weak var maxPeople: UITextField!
    
    let databaseRef = Database.database().reference()
    
    
    
    
    @IBAction func clearSelection(_ sender: Any) {
        chooseLocOut.setTitle("Choose Location", for: .normal)
        subjectOut.text = " "
        messageOut.text = " "
    }
    
    @IBAction func post(_ sender: Any) {
        let btnTitle = chooseLocOut.titleLabel!.text!
        
        if (btnTitle == "Choose Location") {
            
            let alertController = UIAlertController(title: "Alert", message:
                "Select a location", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            
            let userID = Auth.auth().currentUser!.uid
            databaseRef.child("user_profile").child(userID).observe(.value, with: { (snapshot:DataSnapshot) in
                
                //create a dictionary of user's profile data
                let values = snapshot.value as? NSDictionary
                
                
              //  let profileImageURL = (values?["profile_pic"] as? String)!
               // print(profileImageURL)
                
                let profile_pic = Auth.auth().currentUser?.photoURL?.absoluteString
            
            let people = self.maxPeople.text
            let period = self.dateAndTime.date.description
            
            let key = self.databaseRef.child("dinning_posts").childByAutoId().key
            let newValuesForProfile =
                ["location": btnTitle,
                 "userID" : userID,
                 "author": Auth.auth().currentUser?.displayName! as Any,
                 "postID":key,
                 "noGoing": "0",
                 "profile_pic": profile_pic!,
                 "subject": self.subjectOut.text!,
                 "message": self.messageOut.text,
                 "max_people": people!,
                 "time": period] as [String : Any]
            
            let postFeed = ["\(key)" : newValuesForProfile]
            
            self.databaseRef.child("studyGroup_posts").updateChildValues(postFeed)
            
            })
            let alertController = UIAlertController(title: "Confirmation", message:
                "Your Study Group invitation has been posted publicly", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)

        }
        
          }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
