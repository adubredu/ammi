//
//  FeedVC.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 7/11/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class FeedVC: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let dinningController = dinning()
//        let studyController = study()
//       // let activitiesController = activities()
//        let friendsController = friends()
//        let aboutmeController = aboutme()
//        
//        dinningController.title = "Dinning"
//        studyController.title = "Study Group"
// //       activitiesController.title = "Your Activities"
//        friendsController.title = "Friends"
//        aboutmeController.title = "About me"
//        
//        dinningController.tabBarItem.image = UIImage(named:"icons8-Rice Bowl Filled-50")
//        studyController.tabBarItem.image = UIImage(named: "icons8-Reading Filled-50")
//   //     activitiesController.tabBarItem.image = UIImage(named: "icons8-Natural User Interface 1-64")
//        friendsController.tabBarItem.image = UIImage(named: "icons8-Friends Filled-50")
//        aboutmeController.tabBarItem.image = UIImage(named: "icons8-User-48")
//        
//        viewControllers = [dinningController, studyController,  friendsController,aboutmeController]
//    
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
    
    @IBAction func signOutButton(_ sender: Any) {
        FBSDKLoginManager().logOut()
        //performsegue
        performSegue(withIdentifier: "loggedOut", sender: self)
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: "opened")

        //change to false
    }
    
    }
