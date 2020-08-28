//
//  User.swift
//  gameofchats
//
//  Created by Brian Voong on 6/29/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class User: NSObject {
     var id: String?
    var username: String?
    var email: String?
    var search: String?
    var status: String?
    var imageURL: String?
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.username = dictionary["username"] as? String
        self.email = dictionary["email"] as? String
        self.search = dictionary["search"] as? String
        self.status = dictionary["status"] as? String
        self.imageURL = dictionary["imageURL"] as? String
    }
}
