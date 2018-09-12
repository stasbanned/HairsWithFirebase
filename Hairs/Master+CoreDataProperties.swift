//
//  Master+CoreDataProperties.swift
//  Hairs
//
//  Created by Станислав Тищенко on 27.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//
//

import Foundation
import CoreData


extension Master {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Master> {
        return NSFetchRequest<Master>(entityName: "Master")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var event: Event?

}
