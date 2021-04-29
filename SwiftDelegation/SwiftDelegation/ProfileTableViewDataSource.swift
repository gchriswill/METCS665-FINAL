//
//  ProfileTableViewDataSource.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/29/21.
//

import UIKit

/**
 DELEGATION COMPONENT: The delegate/data-source object
 
 A class for handling the delegated behaviour for the `ProfileTableViewController`
 The `UITableViewDataSource` is the interfacte where declares the behavior we are delegating to this object.
 This object impelements the behavior conforming with the needs of the controller that is delegating the behavior.
 */
class ProfileTableViewDataSource: NSObject, UITableViewDataSource {
    
    // The collection for holding the data at runtime
    var profiles: [Data] = [Data]()

    // A default native delegate method that gets called for determining the sections of the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // A default native delegate method that gets called for every section of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    // A default native delegate method that gets called for every row in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Potential usecase for a Delegation or Factory Method pattern for the behavior of cell configuration with Profile class
        let identifier = "edu.bu.chriswgm.ProfileTableViewCell.profilecell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let profile = try? JSONDecoder().decode(Profile.self, from: profiles[indexPath.row]) {
            
            cell.textLabel?.text = profile.username
            cell.detailTextLabel?.text = "\(profile.name) \(profile.lastname) : \(profile.email)"
        }
        
        return cell
    }
    
    // A default native delegate method that gets called to confirm that the user can swipe to delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // A default native delegate method that gets called when the user swipes to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if profiles.indices.contains(indexPath.row) {
                
                profiles.remove(at: indexPath.row)
                
                UserDefaults.standard.setValue(profiles, forKey: ProfilesTableViewController.keyId)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
