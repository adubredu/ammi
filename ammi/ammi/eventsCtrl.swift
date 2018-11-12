//
//  eventsCtrl.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu and David Ngetich on 9/1/17.
//  Copyright © 2017 ammi team. All rights reserved.
//

import UIKit
import Firebase

class eventsCtrl: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableview: UITableView!
    
    let databaseRef = Database.database().reference()
    let userID = Auth.auth().currentUser!.uid
    
   
    var postS = [Downloaded_Posts]()
    var postD = [Downloaded_Posts]()
    
    
    
    
  /*  func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>)
        -> Dictionary<K,V>
    {
        var map = Dictionary<K,V>()
        for (k, v) in left {
            map[k] = v
        }
        for (k, v) in right {
            map[k] = v
        }
        return map
    }*/
    

    
    
    
    func fetchPosts() {
        
        databaseRef.child("Posts").queryOrderedByKey().observe(.value, with: { (snapshot: DataSnapshot)
            in
            
            let values = snapshot.value as! [String : AnyObject]
            
            for(_,post) in values {
                let posD = Downloaded_Posts()
                if let people = post["peopleGoing"] as? [String : AnyObject] {
                    for(id,person) in people {
                        
                        for employee in self.postD {
                            if id == employee.postID {
                                let i = self.postD.index(of: employee)
                                self.postD.remove(at: i!)
                            }
                        }
                        
                        if self.userID == person as! String {
                            posD.ammi_name = post["ammi_name"] as? String
                            posD.ammi_purpose = post["ammi_purpose"] as? String
                            posD.ammi_date = post["ammi_date"] as? String
                            posD.ammi_time = post["ammi_time"] as? String
                            posD.noGoing = post["noGoing"] as? String
                            posD.authorProfilePic = post["profile_pic"] as? String
                            posD.postID = id
                            
                            self.postD.append(posD)
                            
                            self.tableview.reloadData()
                        }
                    }
                }
            }
        })
        self.databaseRef.removeAllObservers()
        
        
        ////////////////////////////////////////
        
        
        
        /////////////////////////////
        
        
        
        
        //////////////////////////////////
        
        databaseRef.child("Private_Posts").queryOrderedByKey().observe(.value, with: { (snapshot: DataSnapshot)
            in
            
            let values = snapshot.value as! [String : AnyObject]
            
            for(_,post) in values {
                let posS = Downloaded_Posts()
                if let people = post["peopleGoing"] as? [String : AnyObject] {
                    for(id,person) in people {
                        
                        for employee in self.postD {
                            if id == employee.postID {
                                let i = self.postD.index(of: employee)
                                self.postD.remove(at: i!)
                            }
                        }
                        
                        if self.userID == person as! String {
                            posS.ammi_name = post["ammi_name"] as? String
                            posS.ammi_purpose = post["ammi_purpose"] as? String
                            posS.ammi_date = post["ammi_date"] as? String
                            posS.ammi_time = post["ammi_time"] as? String
                            posS.noGoing = post["noGoing"] as? String
                            posS.authorProfilePic = post["profile_pic"] as? String
                            posS.postID = id
                            
                            
                            self.postD.append(posS)
                            
                            self.tableview.reloadData()
                        }
                    }
                    
                }
            }
        
            
        })
        self.tableview.reloadData()
        self.databaseRef.removeAllObservers()
        
        //postAll = postD + postS
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }

  
    
    /*
    func updateEvents() {
        databaseRef.child("user_profile").child(userID).updateChildValues(["events_attending":postD])
   }
    
   */

    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.postD.count
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ecell", for: indexPath) as! EventTableViewCell
        
        cell.ammi_name.text = self.postD[indexPath.row].ammi_name
        cell.ammi_purpose.text = self.postD[indexPath.row].ammi_purpose
        cell.num_going.text = "\(self.postD[indexPath.row].noGoing!) people going"
        cell.ammi_date.text = self.postD[indexPath.row].ammi_date
        cell.ammi_time.text = self.postD[indexPath.row].ammi_time
        
        
        let imgURL = self.postD[indexPath.row].authorProfilePic
        
        let url = URLRequest(url: URL(string: imgURL!)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                cell.author_image.image = UIImage(data: data!)
            }
        }
        task.resume()
        return cell
    }
    

    
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.tableview.reloadData()
        fetchPosts()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /******************************************************
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    *****************************************************/

}
