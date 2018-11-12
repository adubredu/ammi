//
//  activities.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu and David Ngetich on 7/18/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import Firebase

class studyInv: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    @IBOutlet weak var tableview: UITableView!
    
    let databaseRef = Database.database().reference()
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    var posts = [SPost]()
    
    
    func fetchPosts() {
        
        databaseRef.child("studyGroup_posts").queryOrderedByKey().observe(.value, with: { (snapshot:DataSnapshot) in
            
            //create a dictionary of user's profile data
            //let values = snapshot.value as? NSDictionary
            let values = snapshot.value as! [String : AnyObject]
            
            for(_,post) in values {
                let posst = SPost()
                //print(post)
                let author = post["author"] as? String
                let location = post["location"] as? String
                let message = post["message"] as? String
                let profile_pic = post["profile_pic"] as? String
                let time = post["time"] as? String
                let postID = post["postID"] as? String
                let max_people = post["max_people"] as? String
                let subject = post["subject"] as? String
                let numGoing = post["noGoing"] as? String
                
                //print(author)
                posst.author = author
                posst.location = location
                posst.max_people = max_people
                posst.message = message
                posst.profile_pic = profile_pic
                posst.time = time
                posst.postID = postID
                posst.subject = subject
                posst.noGoing = numGoing
                
                if let people = post["peopleGoing"] as? [String : AnyObject] {
                    for (_,person) in people {
                        posst.peopleGoing.append(person as! String)
                    }
                }
                
                for employee in self.posts {
                    if (postID)! == employee.postID {
                        let i = self.posts.index(of: employee)
                        self.posts.remove(at: i!)
                    }
                }

                
                self.posts.append(posst)
                //print(self.posts)
                
                
                self.tableview.reloadData()
                
                
            }
            
        }
        )
        self.databaseRef.removeAllObservers()
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scell", for: indexPath) as! StudyTableViewCell
        
        cell.username.text = self.posts[indexPath.row].author
        cell.message.text = self.posts[indexPath.row].message
        cell.location.text = self.posts[indexPath.row].location
        cell.max_people.text = self.posts[indexPath.row].max_people
        cell.time.text = self.posts[indexPath.row].time
        cell.subject.text = self.posts[indexPath.row].subject
        cell.postID = self.posts[indexPath.row].postID
        
        
        let imgURL = self.posts[indexPath.row].profile_pic
        
        let url = URLRequest(url: URL(string: imgURL!)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                cell.userImage.image = UIImage(data: data!)
            }
        }
        task.resume()
        
        for person in self.posts[indexPath.row].peopleGoing {
            
            if person == Auth.auth().currentUser!.uid {
                cell.goingOut.isHidden = true
                cell.cancelOut.isHidden = false
                break
            }
        }
        
        return cell

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
