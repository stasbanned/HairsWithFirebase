//
//  InfoAboutMasterVC.swift
//  Hairs
//
//  Created by Станислав Тищенко on 28.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit
import Firebase

class InfoAboutMasterVC: UIViewController {
    var masterName = ""
    var userName = ""
    var userEmail = ""

    @IBOutlet weak var nameOfMasterLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func bookingButton(_ sender: Any) {
        let firebaseBranch = Database.database().reference(withPath: "users")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let userItem = UserItem(name: userName, master: masterName, date: dateFormatter.string(from: datePicker.date), email: userEmail)
        let userItemInFirebase = firebaseBranch.child(userName)
        userItemInFirebase.setValue(userItem.toAnyObject())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfMasterLabel.text = masterName
    }
}
