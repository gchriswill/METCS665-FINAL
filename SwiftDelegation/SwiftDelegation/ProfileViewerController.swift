//
//  ProfileViewerController.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import UIKit

/**
 A controller class for managing the views and data for the data presentation screen of a single profile
 */
class ProfileViewerController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    // Binder Outlets for linking the accessed views to the controller
    // Basically this properties are the association part of the views to the controller
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    // The binder action to return to this controller and calling a refresh of the data
    @IBAction func viewerUnwindSegue(_ sender: UIStoryboardSegue) {
        
        if let viewer = sender.destination as? ProfileViewerController {
            
            guard let editor = sender.source as? ProfileEditorController else {
                return
            }
            
            viewer.profile = editor.profile
            viewer.nameLabel.text = viewer.profile?.name
            viewer.lastNameLabel.text = viewer.profile?.lastname
            viewer.emailLabel.text = viewer.profile?.email
        }
    }
    
    // The binder action to delete a single data point profile
    @IBAction func profileDeleteAction(_ sender: UIBarButtonItem) {
        
        deleteProfile()
        
        self.performSegue(withIdentifier: "edu.bu.chriswgm.UIStoryboardSegue.unwind.profiles2", sender: self)
    }
    
    // The profile data object for temporary holding
    var profile: Profile?
    
    // Default native Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = profile?.username
        self.navigationController?.title = profile?.username
        
        nameLabel.text = profile?.name
        lastNameLabel.text = profile?.lastname
        emailLabel.text = profile?.email
    }
    
    // Potential usecase for a Delegation for the behavior
    // A default native method that triggers prior navigation to another screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let editor = segue.destination as? ProfileEditorController {
            
            guard let segueIdentifier = segue.identifier else {
                return
            }
            
            guard let viewer = segue.source as? ProfileViewerController else {
                return
            }
            
            editor.configuration = ProfileEditorController.EditorConfiguration(rawValue: segueIdentifier)
            
            editor.profile = viewer.profile
        }
    }
    
    // The function that executes the deletion of a single data point 
    func deleteProfile() {
        // Potential usecase for a Delegation pattern for the behavior of cell configuration with Profile class
        var profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
        
        let firstIndexOcurrance = profiles.firstIndex(where: { (dataProfile) -> Bool in
            
            guard let profileData = try? JSONDecoder().decode(Profile.self, from: dataProfile) else {
                return false
            }
            
            return self.profile?.isEqual(profileData) ?? false
        })
        
        if let index = firstIndexOcurrance {
            
            profiles.remove(at: index)
            UserDefaults.standard.setValue(profiles, forKey: ProfilesTableViewController.keyId)
        }
    }
}
