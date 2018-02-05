//
//  PostViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/7/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {

    var myFeed = [String:[String:Any]]()
    
    var isPrivate = false

    @IBOutlet weak var ammiName: UITextField!
    @IBOutlet weak var ammiDescription: UITextView!
    @IBOutlet weak var ammiPurpose: UITextField!
    @IBOutlet weak var ammiLocation: UITextField!
    @IBOutlet weak var maxNumPeople: UITextField!
    @IBOutlet weak var keywordOne: UITextField!
    @IBOutlet weak var keywordTwo: UITextField!
    @IBOutlet weak var keywordFour: UITextField!
    @IBOutlet weak var keywordFive: UITextField!
    @IBOutlet weak var keywordEight: UITextField!
    @IBOutlet weak var keywordNine: UITextField!
    @IBOutlet weak var keywordSeven: UITextField!
    @IBOutlet weak var keywordSix: UITextField!
    @IBOutlet weak var keywordThree: UITextField!
    @IBOutlet weak var ammiDateAndTime: UIDatePicker!
    @IBOutlet weak var createButton: UIButton!
    
    let databaseRef = Database.database().reference()
    
    @IBOutlet weak var passcodeField: UIStackView!
    
    @IBAction func clearIsPressed(_ sender: Any)
    {
        ammiName.text=""
        ammiDescription.text=""
        ammiPurpose.text=""
        ammiLocation.text=""
        maxNumPeople.text=""
        keywordOne.text=""
        keywordTwo.text=""
        keywordThree.text=""
        keywordFour.text=""
        keywordFive.text=""
        keywordSix.text=""
        keywordSeven.text=""
        keywordEight.text=""
        keywordNine.text=""
    }
    
//    func addToUserProfile()
//    {
//        let userID = Auth.auth().currentUser?.uid
//        let dref = Database.database().reference()
//        dref.child("user_profile").child(userID!).child("my_posts").updateChildValues(self.myFeed)
//    }
    
    
    
    
    @IBAction func createIsPressed(_ sender: Any)
    {
        
        
        if (ammiName.text == "")
        {
            
            let alertController = UIAlertController(title: "Alert", message:
                "Please enter the name of your ammi", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else if (ammiLocation.text == "")
        {
            
            let alertController = UIAlertController(title: "Alert", message:
                "Please enter the location of your ammi", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else
        {
            
            let userID = Auth.auth().currentUser!.uid
            databaseRef.child("user_profile").child(userID).observe(.value, with: { (snapshot:DataSnapshot) in
                
                //create a dictionary of user's profile data //let values
                let value = snapshot.value as! [String : AnyObject]
                let profile_pic = value["profile_picture"] as? String //Auth.auth().currentUser?.photoURL?.absoluteString
                
                let key = self.databaseRef.child("Posts").childByAutoId().key
                let autokey = self.databaseRef.child("Posts").child("peopleGoing").childByAutoId().key
                
                let dateFormatter = DateFormatter()
                let timeFormatter = DateFormatter()
                
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                dateFormatter.locale = Locale(identifier: "en_US")
                
                timeFormatter.timeStyle = .short
                timeFormatter.dateStyle = .none
                timeFormatter.locale = Locale(identifier: "en_US")
                
                let ammidate = dateFormatter.string(from: self.ammiDateAndTime.date)
                let ammitime = timeFormatter.string(from: self.ammiDateAndTime.date)
                
                if (!self.isPrivate)
                {
                let newValuesForProfile =
                    [
                     "userID" : userID,
                     "author": Auth.auth().currentUser?.displayName! as Any,
                     "postID":key,
                     "noGoing": "1",
                     "profile_pic": profile_pic!,
                     "ammi_name" : self.ammiName.text!,
                     "ammi_description" : self.ammiDescription.text,
                     "ammi_purpose" : self.ammiPurpose.text as Any,
                     "ammi_location" : self.ammiLocation.text as Any,
                     "ammi_maxNumPeople" : self.maxNumPeople.text as Any,
                     "peopleGoing" : [autokey : userID],
                     "ammi_keywords" : [self.keywordOne.text,self.keywordTwo.text,self.keywordThree.text,self.keywordFour.text,self.keywordFive.text,self.keywordSix.text,self.keywordSeven.text,self.keywordEight.text,self.keywordNine.text],
                     "ammi_date": ammidate,
                     "ammi_time": ammitime
                        
                        ] as [String : Any]
    
                
                  let postFeed = ["\(key)" : newValuesForProfile]
  
                self.databaseRef.child("Posts").updateChildValues(postFeed)
            }
                else if (self.isPrivate)
                {
                    let private_key = self.databaseRef.child("Private_Posts").childByAutoId().key
                    let newValuesForProfile =
                        [
                            "userID" : userID,
                            "author": Auth.auth().currentUser?.displayName! as Any,
                            "postID":private_key,
                            "noGoing": "1",
                            "profile_pic": profile_pic!,
                            "ammi_name" : self.ammiName.text!,
                            "passcode" : self.ammiPassCode.text as Any,
                            "ammi_description" : self.ammiDescription.text,
                            "ammi_purpose" : self.ammiPurpose.text as Any,
                            "ammi_location" : self.ammiLocation.text as Any,
                            "ammi_maxNumPeople" : self.maxNumPeople.text as Any,
                            "peopleGoing" : [autokey : userID],
                            "ammi_keywords" : [self.keywordOne.text,self.keywordTwo.text,self.keywordThree.text,self.keywordFour.text,self.keywordFive.text,self.keywordSix.text,self.keywordSeven.text,self.keywordEight.text,self.keywordNine.text],
                            "ammi_date": ammidate,
                            "ammi_time": ammitime
                            ] as [String : Any]
                    
                    
                    let postFeed = ["\(private_key)" : newValuesForProfile]
                    self.databaseRef.child("Private_Posts").updateChildValues(postFeed)
                }
                self.databaseRef.removeAllObservers()
                
                
            })
            
            let alertController = UIAlertController(title: "Confirmation", message:
                "Your ammi has been posted", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }
    
    
    func hide_private()
    {
        if (!isPrivate)
        {
            passcodeField.isHidden = true
        }
        
        else
        {
            passcodeField.isHidden = false
        }
    }
    
    
    
    @IBOutlet weak var private_switch: UISwitch!
    @IBOutlet weak var ammiPassCode: UITextField!
    
    @IBAction func private_switch_pressed(_ sender: Any)
    {
        if (private_switch.isOn)
        {
            isPrivate = true
            hide_private()
        }
        
        else if (!private_switch.isOn)
        {
            isPrivate = false
            hide_private()
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hide_private()
    
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
