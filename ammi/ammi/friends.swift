//
//  friends.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu and  David  ngetich on 7/18/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class friends: UIViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
        FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: params).start
            { (connection, result , error) -> Void in
                        if error != nil
            {
                print(error!)
            }
            else {
                print("Friends are...")
                print(result!)
                //Do further work with response
            }
    }
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
