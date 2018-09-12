//
//  Master+CoreDataClass.swift
//  Hairs
//
//  Created by Станислав Тищенко on 27.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Master)
public class Master: NSManagedObject {
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class func saveObject(login: String, password: String, name: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Master", in: context)
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
    class func fetchObject() -> [Master]? {
        let context = getContext()
        var master: [Master]? = nil
        do {
            master = try context.fetch(Master.fetchRequest())
            return master
        } catch {
            return master
        }
    }
    class func deleteObject(master: Master) -> Bool {
        let contex = getContext()
        contex.delete(master)
        do {
            try contex.save()
            return true
        } catch {
            return false
        }
    }
}
