//
//  UserItem.swift
//  Hairs
//
//  Created by Станислав Тищенко on 10.09.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import Foundation
import Firebase

struct UserItem {

    let ref: DatabaseReference?
    let key: String
    let name: String
    let master: String
    let date: String
    let email: String

    init(name: String, master: String = "", date: String = "", email: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.master = master
        self.date = date
        self.email = email
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let master = value["master"] as? String,
            let date = value["date"] as? String,
            let email = value["email"] as? String else {
                return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.master = master
        self.date = date
        self.email = email
    }

    func toAnyObject() -> Any {
        return [
            "name": name,
            "master": master,
            "date": date,
            "email": email
        ]
    }
}
