//
//  InfoAboutMaster.swift
//  Hairs
//
//  Created by Станислав Тищенко on 30.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit

class InfoAboutMaster {
    func getInfoAboutMaster(datePicker: UIDatePicker, userName: String) {
        var event: [Event]? = nil
        event = Event.fetchObject()
        let dat = datePicker.date
        for i in event! {
            if i.date == nil && i.master != nil && i.user != nil {
                if userName == i.user?.name {
                    Event.saveObject(date: dat as NSDate, userName: i.user, masterName: i.master)
                    print("Booked:")
                    print("For user: \(i.user?.name!)")
                    print("To master: \(i.master?.name!)")
                    print("Date: \(dat as NSDate)")
                    Event.deleteObject(event: i)
                    event = Event.fetchObject()
                }
            }
        }
        for i in event! {
            if i.date == nil && i.master != nil && i.user != nil {
                Event.deleteObject(event: i)
            }
        }
        event = Event.fetchObject()
        for i in event! {
            if i.date != nil && i.master != nil && i.user != nil {
            }
        }
    }
}
