//
//  AuthorizationVC.swift
//  Hairs
//
//  Created by Станислав Тищенко on 27.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class AuthorizationVC: UIViewController, AuthorizationProtocol, UITextFieldDelegate {
    lazy var authorization = Authorization(delegate: self)
    let firebaseBranchUsers = Database.database().reference(withPath: "users")
    let firebaseBranchMasters = Database.database().reference(withPath: "masters")
    var userItems: [UserItem] = []
    var masterItems: [MasterItem] = []
    @IBOutlet weak var customLabel: UILabel!
    @IBAction func touchUpButton(_ sender: Any) {
        customLabel.isHidden = true
    }
    @IBAction func touchDownButton(_ sender: Any) {
        customLabel.isHidden = false
    }
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userOrMasterControl: UISegmentedControl!
    @IBAction func logInButton(_ sender: Any) {
        authorization.authNewUserOrMaster(performSegue: performSegue(withIdentifier:sender:),
                                          withIdentifierforUser: "toListOfMasters",
                                          withIdentifierforMaster: "toListOfUsers", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        self.loginText.delegate = self
        customLabel.isHidden = true
        customLabel.layer.cornerRadius = 5
        customLabel.layer.backgroundColor = UIColor.red.cgColor
        customLabel.layer.shadowRadius = 10.0
        customLabel.layer.shadowOpacity = 10.0
        customLabel.layer.shadowOffset = CGSize(width: 0, height: 0)

        firebaseBranchUsers.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let userItem = UserItem(snapshot: snapshot) {

                    self.userItems.append(userItem)
                }
            }
        })

        firebaseBranchMasters.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let masterItem = MasterItem(snapshot: snapshot) {
                    self.masterItems.append(masterItem)
                }
            }
        })

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        _ = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListOfMasters" {
            let destination = segue.destination as! ListOfMasterTableVC
            if userOrMasterControl.selectedSegmentIndex == 0 {
                for j in userItems {
                    if j.email == loginText.text {
                        destination.userName = j.name
                        destination.userEmail = j.email
                    }
                }
            }
        }
        if segue.identifier == "toListOfUsers" {
            let destination = segue.destination as! ListOfUsersTableVC
            if userOrMasterControl.selectedSegmentIndex == 1 {
                for j in masterItems {
                    if j.email == loginText.text {
                        destination.masterName = j.name
                    }
                }
            }
        }
    }
    func getSegmentControlValue() -> Int {
        if userOrMasterControl.selectedSegmentIndex == 0 {
            return 0
        }
        return 1
    }
    func getLoginText() -> String {
        return loginText.text!
    }
    func getPasswordText() -> String {
        return passwordText.text!
    }
    func changeColorOfPasswodField() {
        if passwordText.text == "" {
            passwordText.layer.borderWidth = 1.0
            passwordText.layer.borderColor = UIColor.red.cgColor
        } else {
            passwordText.layer.borderWidth = 0
            passwordText.layer.borderColor = nil
        }
    }
}
