//
//  Event+CoreDataClass.swift
//  Hairs
//
//  Created by Станислав Тищенко on 27.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Event)
public class Event: NSManagedObject {
    class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class func saveObject(date: NSDate?, userName: User?, masterName: Master?) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(date, forKey: "date")
        manageObject.setValue(userName, forKey: "user")
        manageObject.setValue(masterName, forKey: "master")
        do {
            try context.save()
            //print("save")
            return true
        } catch {
            //print("not save")
            return false
        }
    }
    class func fetchObject() -> [Event]? {
        let context = getContext()
        var event: [Event]? = nil
        do {
            event = try context.fetch(Event.fetchRequest())
            return event
        } catch {
            return event
        }
    }
    class func deleteObject(event: Event) -> Bool {
        let contex = getContext()
        contex.delete(event)
        do {
            try contex.save()
            return true
        } catch {
            return false
        }
    }
}
