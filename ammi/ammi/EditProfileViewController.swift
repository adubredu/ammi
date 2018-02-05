//
//  EditProfileViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/20/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {

    var username = String()
    var classYear = String()
    var MajorName = String()
    var pictureUrl = String()
    
   
    
    @IBOutlet weak var name: UILabel!
    
    let databaseRef = Database.database().reference()

    @IBOutlet weak var profilepic: UIImageView!
    
    @IBOutlet weak var classyear: UITextField!
    @IBOutlet weak var major: UITextField!
    
    @IBOutlet weak var savebutton: UIButton!
    
    @IBAction func saveButtonIsPressed(_ sender: Any)
    {
        classYear = classyear.text!
        MajorName = major.text!
        
        if let userID = Auth.auth().currentUser?.uid
        {
            let updates =
            [
                "classYear" : classYear,
                "major" : MajorName,
                "profile_picture" : self.pictureUrl
            ] as [String : Any]
            
            let updateprofile = ["\(userID)" : updates]
            databaseRef.child("user_profile").updateChildValues(updateprofile)
        }
        databaseRef.removeAllObservers()
        performSegue(withIdentifier: "goToAboutMe", sender: self)
    }
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let url = URL(string: pictureUrl)
        {
            self.downloadImage(url: url)
        }
        else {print("url failed")}
        
        name.text = username

       
    }

    func embellish()
    {
        profilepic.layer.borderWidth = 1.0
        profilepic.layer.masksToBounds = false
        profilepic.layer.borderColor = UIColor.white.cgColor
        profilepic.clipsToBounds = true
        
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
                self.profilepic.layer.cornerRadius = 60.0
                self.profilepic.layer.borderColor = UIColor.white.cgColor
                self.profilepic.layer.masksToBounds = true
                self.profilepic.image = UIImage(data: data)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
