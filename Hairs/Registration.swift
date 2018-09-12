//
//  Registration.swift
//  Hairs
//
//  Created by Станислав Тищенко on 30.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit
import Firebase

protocol RegistrationProtocol {
    func getSegmentControlValue() -> Int
    func getLoginText() -> String
    func getPasswordText() -> String
    func getConfirmText() -> String
    func getNameText() -> String
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
}

class Registration {
    var delegate: RegistrationProtocol?
    let firebaseBranchMasters = Database.database().reference(withPath: "masters")
    let firebaseBranchUsers = Database.database().reference(withPath: "users")
    init(delegate: RegistrationProtocol) {
        self.delegate = delegate
    }
    func regNewUserOrMaster(performSegue: (String, Any?) -> (), withIdentifier: String, sender: Any?) {
        let invalidInput = false
        if delegate?.getSegmentControlValue() == 0 {
            if delegate?.getPasswordText() == delegate?.getConfirmText() && delegate?.getLoginText() != ""
                && delegate?.getPasswordText() != "" && delegate?.getNameText() != ""{
                if invalidInput == false {
                    print("Successful registration")
                    let emailField = delegate?.getLoginText()
                    let passwordField = delegate?.getPasswordText()
                    Auth.auth().createUser(withEmail: emailField! + "user", password: passwordField!) { user, error in
                        print(error)
                    }
                    let userItem = UserItem(name: (delegate?.getNameText())!, email: (delegate?.getLoginText())!)
                    let userItemInFirebase = self.firebaseBranchUsers.child((delegate?.getNameText())!)
                    userItemInFirebase.setValue(userItem.toAnyObject())

                    performSegue(withIdentifier, sender)
                    delegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }
            }
        } else {
            if delegate?.getPasswordText() == delegate?.getConfirmText() && delegate?.getLoginText() != ""
                && delegate?.getPasswordText() != "" && delegate?.getNameText() != ""{
                if invalidInput == false {
                    let emailField = delegate?.getLoginText()
                    let passwordField = delegate?.getPasswordText()
                    Auth.auth().createUser(withEmail: emailField! + "master", password: passwordField!) { user, error in
                        print(error)
                    }
                    let masterItem = MasterItem(name: (delegate?.getNameText())!, email: (delegate?.getLoginText())!)
                    let masterItemInFirebase = self.firebaseBranchMasters.child((delegate?.getNameText())!)
                    masterItemInFirebase.setValue(masterItem.toAnyObject())
                    
                    print("Successful registration")
                    performSegue(withIdentifier, sender)
                    delegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }
            }
        }
    }
}
