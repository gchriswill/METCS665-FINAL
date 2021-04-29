//
//  ProfilesTableViewController.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import UIKit

/**
 A class for managing and controlling the views and data of the table list.
 */
class ProfilesTableViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    // The key id for storing the data
    public static let keyId = "edu.bu.gchriswgm.SwiftDelegation.UserDefaults.profiles.KEY"
    
    // The collectiong for holding the data at runtime
    var profiles: [Data] = [Data]()
    
    // The binder action to return to this controller and calling a refresh of the data
    @IBAction func profilesUnwindSegue(_ sender: UIStoryboardSegue) {
        
        if let pvc = sender.destination as? ProfilesTableViewController {
            
            pvc.profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
            pvc.tableView.reloadData()
        }
    }
    
    // The bidner action to clear all the data
    @IBAction func clearAllAction(_ sender: UIBarButtonItem) {
        profiles.removeAll()
        UserDefaults.standard.setValue(profiles, forKey: ProfilesTableViewController.keyId)
        tableView.reloadSections([0], with: .automatic)
    }
    
    // Default native Life cycle method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
        self.tableView.reloadData()
    }
    
    // Default native Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Potential usecase for a Delegation for the behavior
    // A default native delegate method that gets called for determining the sections of the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Potential usecase for a Delegation for the behavior
    // A default native delegate method that gets called for every section of the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    // Potential usecase for a Delegation for the behavior
    // A default native delegate method that gets called for every row in the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Potential usecase for a Delegation or Factory Method pattern for the behavior of cell configuration with Profile class
        let identifier = "edu.bu.chriswgm.ProfileTableViewCell.profilecell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let profile = try? JSONDecoder().decode(Profile.self, from: profiles[indexPath.row]) {
            
            cell.textLabel?.text = profile.username
            cell.detailTextLabel?.text = "\(profile.name) \(profile.lastname) : \(profile.email)"
        }
        
        return cell
    }
    
    // Potential usecase for a Delegation for the behavior
    // A default native delegate method that gets called to confirm that the user can swipe to delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Potential usecase for a Delegation for the behavior
    // A default native delegate method that gets called when the user swipes to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if profiles.indices.contains(indexPath.row) {
                
                profiles.remove(at: indexPath.row)
                
                UserDefaults.standard.setValue(profiles, forKey: ProfilesTableViewController.keyId)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // Potential usecase for a Delegation for the behavior
    // A default native method that triggers prior navigation to another screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let editor = segue.destination as? ProfileEditorController {
            
            guard let segueIdentifier = segue.identifier else {
                return
            }
            
            editor.configuration = ProfileEditorController.EditorConfiguration(rawValue: segueIdentifier)
            
            editor.presentationController?.delegate = self
        }
        
        if let viewer = segue.destination as? ProfileViewerController {
            
            guard let pvc = segue.source as? ProfilesTableViewController else {
                return
            }
            
            guard let profileCell = sender as? ProfileTableViewCell else {
                return
            }
            
            guard let indexPath = pvc.tableView.indexPath(for: profileCell) else {
                return
            }
            
            guard pvc.profiles.indices.contains(indexPath.row) else {
                return
            }
            
            guard  let profile = try? JSONDecoder().decode(Profile.self, from: pvc.profiles[indexPath.row]) else {
                return
            }
            
            viewer.profile = profile
        }
    }
    
    // Potential usecase for a Delegation pattern for the behavior
    // A native delegate method that will execute upon the user swipes down to dismiss
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        
        if let profilesController = presentationController.delegate as? ProfilesTableViewController {
            
            let dataArray = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
            
            profilesController.profiles = dataArray
            profilesController.tableView.reloadData()
        }
    }
}
