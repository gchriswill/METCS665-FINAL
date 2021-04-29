//
//  ProfilesTableViewController.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import UIKit

/**
 DELEGATION COMPONENT: The delegate/data-source/presenter association holder in form of a controller
 
 A class for managing and controlling the views and data of the table list.
 This object hold the reference of the delegate/data-source and also holds the view object that relies on the behavior for presenting the data.
 The binding of the delegate is made through a storyboard object and referenced/associated here as an outlet binder.
 */
class ProfilesTableViewController: UITableViewController {
    
    // The key id for storing the data
    public static let keyId = "edu.bu.gchriswgm.SwiftDelegation.UserDefaults.profiles.KEY"
    
    /**
     DELEGATION COMPONENT: The delegate/data-source associated object.
     
     This propety holds the association/reference in form of a property outlet that is linked or binded via the storyboard.
     We can held it as strong reference due to the fact that ARC will manage and release when needed.
     */
    @IBOutlet var dataSource: ProfileTableViewDataSource!
    
    /**
     DELEGATION COMPONENT: The delegate/data-source associated object.
     
     This propety holds the association/reference in form of a property outlet that is linked or binded via the storyboard.
     We can held it as strong reference due to the fact that ARC will manage and release when needed.
     */
    @IBOutlet var presenter: ProfilesTableViewControllerPresenter!
    
    // The binder action to return to this controller and calling a refresh of the data
    @IBAction func profilesUnwindSegue(_ sender: UIStoryboardSegue) {
        
        if let pvc = sender.destination as? ProfilesTableViewController {
            
            pvc.dataSource.profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
            pvc.tableView.reloadData()
        }
    }
    
    // The bidner action to clear all the data
    @IBAction func clearAllAction(_ sender: UIBarButtonItem) {
        
        dataSource.profiles.removeAll()
        UserDefaults.standard.setValue(dataSource.profiles, forKey: ProfilesTableViewController.keyId)
        tableView.reloadSections([0], with: .automatic)
    }
    
    // Default native Life cycle method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataSource.profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
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
    // A default native method that triggers prior navigation to another screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let editor = segue.destination as? ProfileEditorController {
            
            guard let segueIdentifier = segue.identifier else {
                return
            }
            
            editor.configuration = ProfileEditorController.EditorConfiguration(rawValue: segueIdentifier)
            
            editor.presentationController?.delegate = presenter
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
            
            guard pvc.dataSource.profiles.indices.contains(indexPath.row) else {
                return
            }
            
            guard  let profile = try? JSONDecoder().decode(Profile.self, from: pvc.dataSource.profiles[indexPath.row]) else {
                return
            }
            
            viewer.profile = profile
        }
    }
}
