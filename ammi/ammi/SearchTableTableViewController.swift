//
//  SearchTableTableViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/7/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit
import Firebase

class SearchTableTableViewController: UITableViewController {

    var posts = [Downloaded_Posts]()
    let databaseRef = Database.database().reference()
    let userID = Auth.auth().currentUser!.uid
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.searchController = UISearchController(searchResultsController: SearchTableTableViewController())
        self.tableView.tableHeaderView = self.searchController.searchBar
        fetchPosts()
        
    }

    
    
    
    func fetchPosts() {
        
        databaseRef.child("Posts").queryOrderedByKey().observe(.value, with: { (snapshot:DataSnapshot) in
            
            //create a dictionary of user's profile data
            //let values = snapshot.value as? NSDictionary
            let values = snapshot.value as! [String : AnyObject]
            
            for(_,post) in values {
                let posst = Downloaded_Posts()
                //print(post)
    
                let ammi_name = post["ammi_name"] as? String
                let ammi_purpose = post["ammi_purpose"] as? String
                let ammi_keywords = post["ammi_keywords"] as? [String]
                let ammi_location = post["ammi_location"] as? String
                let ammi_MaxNumPeople = post["ammi_MaxNumPeople"] as? String
                let ammi_dateAndTime = post["ammi_dateAndTime"] as? String
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
                posst.ammi_dateAndTime = ammi_dateAndTime
                posst.ammi_description = ammi_description
                posst.author = author
                posst.noGoing = noGoing
                posst.postID = postID
                posst.authorProfilePic = authorProfilePic
                posst.authorUserID = authorUserID
                
                
                for employee in self.posts {
                    if (postID)! == employee.postID {
                        let i = self.posts.index(of: employee)
                        self.posts.remove(at: i!)
                    }
                }
  
                self.posts.append(posst)
                
                self.tableView.reloadData()
            }
            
        }
        )
        self.databaseRef.removeAllObservers()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        cell.ammiName.text = self.posts[indexPath.row].ammi_name
        cell.purposeOfAmmi.text = self.posts[indexPath.row].ammi_purpose
        cell.goingImage.image = UIImage(named:"greencheck")
        cell.numGoing.text = "\(self.posts[indexPath.row].noGoing) people going"
        cell.dateAndTime.text = self.posts[indexPath.row].ammi_dateAndTime
        
        
        let imgURL = self.posts[indexPath.row].authorProfilePic
        
        let url = URLRequest(url: URL(string: imgURL!)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                cell.authorImageView.image = UIImage(data: data!)
            }
        }
        task.resume()
        
        return cell

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class Downloaded_Posts: NSObject
{
    var ammi_name: String!
    var ammi_purpose: String!
    var ammi_keywords: [String]=[String]()
    var ammi_location: String!
    var ammi_MaxNumPeople: String!
    var ammi_dateAndTime: String!
    var ammi_description: String!
    var author: String!
    var noGoing: String!
    var postID: String!
    var authorProfilePic: String!
    var authorUserID: String!
    
   
}
