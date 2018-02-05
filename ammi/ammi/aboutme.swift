//
//  aboutme.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 7/18/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import FBSDKLoginKit
import SwiftyJSON

class aboutme: UIViewController, UINavigationControllerDelegate {
    
    var pictureurl = String()
    var myusername = String()
    
    
    @IBAction func logOut(_ sender: Any)
    {
        FBSDKLoginManager().logOut()
        try! Auth.auth().signOut()
        //performsegue
        performSegue(withIdentifier: "loggedOut", sender: self)
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: "opened")
        
        //change to false
    }
    
  


    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var classYear: UILabel!
    @IBOutlet weak var major: UILabel!
 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var editOut: UIButton!

   
    
    
    @IBAction func editButton(_ sender: Any)
    {
        performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToEdit"
        {
            let gotoedit = segue.destination as! EditProfileViewController
            gotoedit.username = myusername
            gotoedit.pictureUrl = pictureurl
        }
    }
    
    
    var loggedInUser : AnyObject?
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfile()
        loadProfile()
        
       
        }
    
    
    
    
    
    func loadProfile()
    {
        if let userID = Auth.auth().currentUser?.uid {
            databaseRef.child("user_profile").child(userID).observe(.value, with: { (snapshot:DataSnapshot) in
                let values = snapshot.value as? NSDictionary
                
                self.classYear.text = values?["classYear"] as? String
                self.major.text = values?["major"] as? String
                
            })
        }
        classYear.isHidden = false
        major.isHidden = false
        
    }
    
    
    
    func fetchProfile()
    {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error != nil)
                {
                    print(error!)
                    return
                }
                
                let json = JSON(result!)
                let first_name = json["name"].stringValue
                let profilepicture = json["picture"]["data"]["url"].stringValue
                
                
                self.name.text = first_name
                self.pictureurl = profilepicture
                
                if let url = URL(string: profilepicture)
                {
                    self.downloadImage(url: url)
                }
                else {print("url failed")}
                
            })
        }
        
      
        
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    

    func downloadImage(url: URL)
    {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.profilePicture.layer.cornerRadius = 60.0
                self.profilePicture.layer.borderColor = UIColor.white.cgColor
                self.profilePicture.layer.masksToBounds = true
                self.profilePicture.image = UIImage(data: data)
            }
        }
    }
    
    
   

    
     func setProfilePicture(imageView: UIImageView, imageToSet: UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }

 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
