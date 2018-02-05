 //
//  SPost.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 8/25/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit

class SPost: NSObject {
    
    var author: String!
    var message: String!
    var location: String!
    var max_people: String!
    var profile_pic: String!
    var time: String!
    var postID: String!
    var subject: String!
    var noGoing: String!
    
    var peopleGoing: [String] = [String]()
}
