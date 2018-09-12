//
//  ListOfUsersTableVC.swift
//  Hairs
//
//  Created by Станислав Тищенко on 28.05.2018.
//  Copyright © 2018 Станислав Тищенко. All rights reserved.
//

import UIKit
import Firebase

class ListOfUsersTableVC: UITableViewController {
    var masterName = ""
    var userName = ""
    var indexOfSelectedRow = 0
    var arrayOfUsers: [String] = []
    var allUserItems: [UserItem] = []
    var usersForCurrentMaster: [UserItem] = []
    let firebaseBranch = Database.database().reference(withPath: "users")

    override func viewDidLoad() {
        super.viewDidLoad()
        indexOfSelectedRow = 0
        tableView.tableFooterView = UIView()

        firebaseBranch.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let userItem = UserItem(snapshot: snapshot) {
                    self.allUserItems.append(userItem)

                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in allUserItems {
            if i.master == masterName {
                usersForCurrentMaster.append(i)
            }
        }
        return usersForCurrentMaster.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = usersForCurrentMaster[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfSelectedRow = indexPath.row
        performSegue(withIdentifier: "toUserInfo", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! infoAboutUserVC
        destination.userName = usersForCurrentMaster[indexOfSelectedRow].name
        destination.date = usersForCurrentMaster[indexOfSelectedRow].date
        destination.masterName = masterName
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
