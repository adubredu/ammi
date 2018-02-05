//
//  diningCInv.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 8/28/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import Firebase

class diningCInv: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var posts = [Post]()
    
    let databaseRef = Database.database().reference()
    let userID = Auth.auth().currentUser!.uid
    
    let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    
    
    func fetchPosts() {
        
        databaseRef.child("dinning_posts").queryOrderedByKey().observe(.value, with: { (snapshot:DataSnapshot) in
            
            //create a dictionary of user's profile data
            //let values = snapshot.value as? NSDictionary
            let values = snapshot.value as! [String : AnyObject]
            
            for(_,post) in values {
                let posst = Post()
                //print(post)
                let author = post["author"] as? String
                let location = post["location"] as? String
                let meal = post["meal"] as? String
                let profile_pic = post["profile_pic"] as? String
                let time = post["time"] as? String
                let postID = post["postID"] as? String
                let max_people = post["max_people"] as? String
                let numGoing = post["noGoing"] as? String
                
                
                //print(author)
                posst.author = author
                posst.location = location
                posst.max_people = max_people
                posst.meal = meal
                posst.profile_pic = profile_pic
                posst.time = time
                posst.postID = postID
                posst.noGoing = numGoing
                
                self.posts.append(posst)
                //print(self.posts)
                
                
                self.collectionview.reloadData()
                
                
            }
        }
        )
        self.databaseRef.removeAllObservers()
    }
    
    
    
    
    
    
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! DiningCollectionViewCell
        
        //
        
        cell.username.text = self.posts[indexPath.row].author
        cell.mealType.text = self.posts[indexPath.row].meal
        cell.location.text = self.posts[indexPath.row].location
        cell.numberOfPeople.text = self.posts[indexPath.row].max_people
        cell.dateAndTime.text = self.posts[indexPath.row].time
        cell.nuGoing.text = self.posts[indexPath.row].noGoing
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
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
