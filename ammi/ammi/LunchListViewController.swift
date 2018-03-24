//
//  LunchListViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/9/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class LunchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
    var posts = [Downloaded_Posts]()
    var current_posts = [Downloaded_Posts]()
    
    let databaseRef = Database.database().reference()
    let userID = Auth.auth().currentUser!.uid
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchPosts()
        filterLunchPosts()
    }

    func fetchPosts()
    {
        
        databaseRef.child("Posts").queryOrderedByKey().observe(.value, with: { (snapshot:DataSnapshot) in
            
            //create a dictionary of user's profile data
            //let values = snapshot.value as? NSDictionary
            if snapshot.hasChildren() {
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
                posst.author = author
                posst.noGoing = noGoing
                posst.postID = postID
                posst.authorProfilePic = authorProfilePic
                posst.authorUserID = authorUserID
                
                if let people = post["peopleGoing"] as? [String] {
                    for (person) in people {
                        posst.peopleGoing.append(person)
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
                
                self.tableView.reloadData()
                self.filterLunchPosts()
            }
            
            }}
        )
        
        self.databaseRef.removeAllObservers()
        
    }
    
    func filterLunchPosts()
    {
        current_posts = posts
        current_posts = posts.filter({ (a_post) -> Bool in
            let text = "Lunch"
            return (a_post.ammi_name.lowercased().contains(text.lowercased()) || a_post.ammi_keywords.contains(text.lowercased()) || a_post.ammi_purpose.lowercased().contains(text.lowercased()) || a_post.ammi_description.lowercased().contains(text.lowercased()))
        })
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return self.current_posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lunch_cell", for: indexPath) as! LunchPostTableViewCell
        
        cell.ammiName.text = self.current_posts[indexPath.row].ammi_name
        cell.purposeOfAmmi.text = self.current_posts[indexPath.row].ammi_purpose
        cell.goingImage.image = UIImage(named:"greencheck")
        cell.numGoing.text = "\(self.current_posts[indexPath.row].noGoing!) people going"
        cell.date.text = self.current_posts[indexPath.row].ammi_date
        cell.time.text = self.current_posts[indexPath.row].ammi_time
        
        
        let imgURL = self.current_posts[indexPath.row].authorProfilePic
        
        let url = URLRequest(url: URL(string: imgURL!)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                cell.authorImage.image = UIImage(data: data!)
            }
        }
        task.resume()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    {
        if (self.current_posts[indexPath.row].ammi_name) != nil {
            nameofgroup = self.current_posts[indexPath.row].ammi_name}
        
        if (self.current_posts[indexPath.row].ammi_date) != nil {
            meetingdate = self.current_posts[indexPath.row].ammi_date}
        
        if (self.current_posts[indexPath.row].ammi_time) != nil {
            meetingtime = self.current_posts[indexPath.row].ammi_time}
        
        if (self.current_posts[indexPath.row].ammi_location) != nil {
            meetingvenue = self.current_posts[indexPath.row].ammi_location}
        
        if (self.current_posts[indexPath.row].ammi_location) != nil {
            meetingaddress = self.current_posts[indexPath.row].ammi_location}
        
        if (self.current_posts[indexPath.row].author) != nil {
            authorname = self.current_posts[indexPath.row].author}
        
        if (self.current_posts[indexPath.row].noGoing) != nil {
            numbergoing = self.current_posts[indexPath.row].noGoing}
        
        if (self.current_posts[indexPath.row].ammi_purpose) != nil {
            grouppurpose = self.current_posts[indexPath.row].ammi_purpose}
        
        if (self.current_posts[indexPath.row].ammi_description) != nil {
            groupdescription = self.current_posts[indexPath.row].ammi_description }
        
        if (self.current_posts[indexPath.row].ammi_MaxNumPeople) != nil {
            maximum = self.current_posts[indexPath.row].ammi_MaxNumPeople}
        
        if (self.posts[indexPath.row].postID) != nil {
            postID = self.posts[indexPath.row].postID}
        
        people_going = self.posts[indexPath.row].peopleGoing
        
        performSegue(withIdentifier: "showLunchListInfo", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let searchcontroller = segue.destination as! LunchInfoViewController
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
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
