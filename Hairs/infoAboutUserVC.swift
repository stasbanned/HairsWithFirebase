//
//  infoAboutUserVC.swift
//  Hairs
//
//  Created by Станислав Тищенко on 28.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class infoAboutUserVC: UIViewController {
    var masterName = ""
    var userName = ""
    var date = ""
    @IBOutlet weak var nameOfUserLabel: UILabel!
    @IBOutlet weak var dateOfUserLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfUserLabel.text = userName
        dateOfUserLabel.text = date
    }
}
