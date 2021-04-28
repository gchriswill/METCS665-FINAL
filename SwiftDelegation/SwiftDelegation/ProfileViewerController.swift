//
//  ProfileViewerController.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import UIKit

class ProfileViewerController: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    var profile: Profile?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
    
    @IBAction func profileDeleteAction(_ sender: UIBarButtonItem) {
        
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
        
        self.performSegue(withIdentifier: "edu.bu.chriswgm.UIStoryboardSegue.unwind.profiles2", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = profile?.username
        self.navigationController?.title = profile?.username
        
        nameLabel.text = profile?.name
        lastNameLabel.text = profile?.lastname
        emailLabel.text = profile?.email
    }
    
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
}
