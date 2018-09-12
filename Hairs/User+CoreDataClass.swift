//
//  User+CoreDataClass.swift
//  Hairs
//
//  Created by Станислав Тищенко on 27.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class User: NSManagedObject {
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class func saveObject(login: String, password: String, name: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(login, forKey: "login")
        manageObject.setValue(password, forKey: "password")
        manageObject.setValue(name, forKey: "name")
        do {
            try context.save()
            //print("save")
            return true
        } catch {
            //print("not save")
            return false
        }
    }
    class func fetchObject() -> [User]? {
        let context = getContext()
        var user: [User]? = nil
        do {
            user = try context.fetch(User.fetchRequest())
            return user
        } catch {
            return user
        }
    }
    class func deleteObject(user: User) -> Bool {
        let contex = getContext()
        contex.delete(user)
        do {
            try contex.save()
            return true
        } catch {
            return false
        }
    }
}
