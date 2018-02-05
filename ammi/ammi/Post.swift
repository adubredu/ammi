//
//  Post.swift
//  buddy
//
//  Created by Alphonsus Adu-Bredu on 8/24/17.
//  Copyright © 2017 Buddy team. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    var author: String!
    var meal: String!
    var location: String!
    var max_people: String!
    var profile_pic: String!
    var time: String!
    var postID: String!
    var noGoing: String!
    
    var peopleGoing: [String] = [String]()
}
