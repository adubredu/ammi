//
//  PrivateGroupSearchViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/18/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class PrivateGroupSearchViewController: UIViewController {

    var posts = [Downloaded_Posts]()
    var ammi_found = Downloaded_Posts()
    
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
    var people_going: [String] = [String]()
    
    let databaseRef = Database.database().reference()
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var error_message: UILabel!
    
    
    @IBAction func searchIsPressed(_ sender: Any)
    {
        let user_passcode = searchField.text!
        let index = find_post(user_passcode: user_passcode)
        if (index == -1)
        {
            error_message.isHidden = false
        }
        else
        {
            if (self.posts[index].ammi_name) != nil {
                nameofgroup = self.posts[index].ammi_name}
            
            if (self.posts[index].ammi_date) != nil {
                meetingdate = self.posts[index].ammi_date}
            
            if (self.posts[index].ammi_time) != nil {
                meetingtime = self.posts[index].ammi_time}
            
            if (self.posts[index].ammi_location) != nil {
                meetingvenue = self.posts[index].ammi_location}
            
            if (self.posts[index].ammi_location) != nil {
                meetingaddress = self.posts[index].ammi_location}
            
            if (self.posts[index].author) != nil {
                authorname = self.posts[index].author}
            
            if (self.posts[index].noGoing) != nil {
                numbergoing = self.posts[index].noGoing}
            
            if (self.posts[index].ammi_purpose) != nil {
                grouppurpose = self.posts[index].ammi_purpose}
            
            if (self.posts[index].ammi_description) != nil {
                groupdescription = self.posts[index].ammi_description }
            
            if (self.posts[index].ammi_MaxNumPeople) != nil {
                maximum = self.posts[index].ammi_MaxNumPeople}
            
            if (self.posts[index].postID) != nil {
                postID = self.posts[index].postID}
            
            //people_going = self.posts[indexPath.row].peopleGoing
            
            performSegue(withIdentifier: "goToPrivateAmmi", sender: self)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let searchcontroller = segue.destination as! PrivateInfoViewController
        searchcontroller.nameofgroup = nameofgroup
        searchcontroller.meetingdate = meetingdate
        searchcontroller.meetingtime = meetingtime
        searchcontroller.meetingvenue = meetingvenue
        searchcontroller.meetingaddress = meetingaddress
        searchcontroller.authorname = authorname
        searchcontroller.numbergoing = numbergoing
        searchcontroller.grouppurpose = grouppurpose
        searchcontroller.groupdescription = groupdescription
        searchcontroller.maximum = maximum
        searchcontroller.postID = postID
        print(postID)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        error_message.isHidden = true
        fetchPosts()

        
    }

    
    func fetchPosts()
    {
        
        databaseRef.child("Private_Posts").queryOrderedByKey().observe(.value, with: { (snapshot:DataSnapshot) in
            
            //create a dictionary of user's profile data
            //let values = snapshot.value as? NSDictionary
            if (snapshot.hasChildren())
            {
                let values = snapshot.value as! [String : AnyObject]
                
                for(_,post) in values
                {
                    let posst = Downloaded_Posts()
                    //print(post)
                    
                    let ammi_name = post["ammi_name"] as? String
                    let ammi_purpose = post["ammi_purpose"] as? String
                    let ammi_keywords = post["ammi_keywords"] as? [String]
                    let ammi_location = post["ammi_location"] as? String
                    let ammi_MaxNumPeople = post["ammi_MaxNumPeople"] as? String
                    let ammi_date = post["ammi_date"] as? String
                    let ammi_time = post["ammi_time"] as? String
                    let ammi_description = post["ammi_description"] as? String
                    let ammi_passcode = post["passcode"] as? String
                    let author = post["author"] as? String
                    let noGoing = post["noGoing"] as? String
                    let postID = post["postID"] as? String
                    let authorProfilePic = post["profile_pic"] as? String
                    let authorUserID = post["userID"] as? String
                    
                    //print(author)
                    posst.ammi_name = ammi_name
                    posst.ammi_purpose = ammi_purpose
                    posst.ammi_keywords = ammi_keywords!
                    posst.ammi_location = ammi_location
                    posst.ammi_MaxNumPeople = ammi_MaxNumPeople
                    posst.ammi_date = ammi_date
                    posst.ammi_time = ammi_time
                    posst.ammi_description = ammi_description
                    posst.passcode = ammi_passcode
                    posst.author = author
                    posst.noGoing = noGoing
                    posst.postID = postID
                    posst.authorProfilePic = authorProfilePic
                    posst.authorUserID = authorUserID
                    
                    if let people = post["peopleGoing"] as? [String : AnyObject] {
                        for (_,person) in people {
                            posst.peopleGoing.append(person as! String)
                        }
                    }
                    
                    for employee in self.posts
                    {
                        if (postID)! == employee.postID {
                            let i = self.posts.index(of: employee)
                            self.posts.remove(at: i!)
                        }
                    }
                    
                    self.posts.append(posst)
                }
                
            }}
        )
        
        self.databaseRef.removeAllObservers()
        
    }
    
    func find_post (user_passcode : String) -> Int
    {
        var post_index = Int()
        var found = false
        
        for post in posts
        {
            if (post.passcode == user_passcode)
            {
                found = true
                post_index = posts.index(of: post)!
                print(post_index)
                break
            }
        }
        
        if (!found) { return -1}
        else { return post_index }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
