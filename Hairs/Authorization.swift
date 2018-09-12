//
//  Authorization.swift
//  Hairs
//
//  Created by Станислав Тищенко on 30.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit
import Firebase

protocol AuthorizationProtocol {
    func getSegmentControlValue() -> Int
    func getLoginText() -> String
    func getPasswordText() -> String
    func changeColorOfPasswodField()
}

class Authorization {
    var delegate: AuthorizationProtocol?
    init(delegate: AuthorizationProtocol) {
        self.delegate = delegate
    }
    func authNewUserOrMaster(performSegue: @escaping (String, Any?) -> (), withIdentifierforUser: String,
                             withIdentifierforMaster: String, sender: Any?) {

        if delegate?.getSegmentControlValue() == 0 {
            guard
                let email = delegate?.getLoginText(),
                let password = delegate?.getPasswordText(),
                email.count > 0,
                password.count > 0
                else {
                    return
            }
            Auth.auth().signIn(withEmail: email + "user", password: password) { user, error in
                if error == nil {
                    print("ok")
                    performSegue(withIdentifierforUser, sender)
                }
            }
        } else {

            guard
                let email = delegate?.getLoginText(),
                let password = delegate?.getPasswordText(),
                email.count > 0,
                password.count > 0
                else {
                    return
            }

            Auth.auth().signIn(withEmail: email + "master", password: password) { user, error in
                if error == nil {
                    print("ok")
                    performSegue(withIdentifierforMaster, sender)
                }
            }
        }
        delegate?.changeColorOfPasswodField()
    }
}
