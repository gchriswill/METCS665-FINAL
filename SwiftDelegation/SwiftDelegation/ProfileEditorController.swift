//
//  ProfileEditorController.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import UIKit

/**
 
 DELEGATION COMPONENT: The delegate/validator association holder in form of a controller object.
 
 A class controller for managing the view and data of the create/edit screen.
 This class is fully responsible for the creationg and edition of the data and the views updates.
 */
class ProfileEditorController: UIViewController {
    
    // Binder Outlets for linking the accessed views to the controller
    // Basically this properties are the association part of the views to the controller
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var profileEditActionButton: UIButton!
    
    // The binder action from the button view that triggers on user interaction and executes the create/update
    // based on the configuration of the controller
    @IBAction func profileEditAction(_ sender: UIButton) {
        
        let editedProfile = Profile(username: userNameTextField.text ?? "",
                              name: nameTextField.text ?? "",
                              lastname: lastNameTextField.text ?? "",
                              email: emailTextField.text ?? "")
        
        guard validator?.validate(profile: editedProfile) ?? false else {
            return
        }
        
        var profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
        
        guard let data = try? JSONEncoder().encode(editedProfile) else {
            return
        }
        
        let firstIndexOcurrance = profiles.firstIndex(where: { (dataProfile) -> Bool in
            
            guard let profileData = try? JSONDecoder().decode(Profile.self, from: dataProfile) else {
                return false
            }
            
            return editedProfile.isEqual(profileData)
        })
        
        if let index = firstIndexOcurrance {
            profiles[index] = data
        } else {
            profiles.append(data)
        }
        
        UserDefaults.standard.setValue(profiles, forKey: ProfilesTableViewController.keyId)
        
        self.profile = editedProfile
        
        if configuration == .create {
            self.performSegue(withIdentifier: "edu.bu.chriswgm.UIStoryboardSegue.unwind.profiles", sender: self)
        }
        
        if configuration == .update {
            self.performSegue(withIdentifier: "edu.bu.chriswgm.UIStoryboardSegue.unwind.viewer", sender: self)
        }
    }
    
    // The binder action that triggers on user interaction for canceling the create/update
    @IBAction func profileCancelAction(_ sender: UIButton) {
        
        if configuration == .create {
            self.performSegue(withIdentifier: "edu.bu.chriswgm.UIStoryboardSegue.unwind.profiles", sender: self)
        }
        
        if configuration == .update {
            self.dismiss(animated: true)
        }
    }
    
//    var validatorDelegate: ProfileDataVerificationDelegate?
    // An enum for specifying the configuration of the controller
    enum EditorConfiguration: String {
        case create = "edu.bu.chriswgm.UIStoryboardSegue.create",
             update = "edu.bu.chriswgm.UIStoryboardSegue.update"
        
        static func titleName(configuration: EditorConfiguration) -> String {
            
            var name = configuration.rawValue.split(separator: ".").last ?? ""
            let upperFirst = name.first?.uppercased() ?? ""
            name.removeFirst()
            name = upperFirst + name
            
            return String(name)
        }
    }
    
    /**
     DELEGATION COMPONENT: The delegate/validator associated object.
     
     This propety holds the association/reference in form of a variable that is linked via method call `validate`.
     We can held it as strong reference due to the fact that ARC will manage and release the reference.
     Here we can declare this variable type as the interface type due to factors:
     - there is no storyboard dependency
     - it's manual contruction and implementation
     */
    var validator: ProfileDataVerificationDelegate?
    
    // The property for holding the configuration value of the controller
    var configuration: EditorConfiguration?
    
    // The profile data object for temporary holding
    var profile: Profile?
    
    // The constructor of the controller
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        validator = ProfileDataValidator()
    }
    
    // The function to load and configure the view and the data for the given configuration
    func loadEditorConfiguration(configuration: EditorConfiguration) {
        
        let titleName = EditorConfiguration.titleName(configuration: configuration)
        
        self.title = "\(titleName) Profile"
        self.navigationItem.title = "\(titleName) Profile"
        
        profileEditActionButton.setTitle("\(titleName) Profile", for: .normal)
        
        if configuration == .update {
            
            userNameTextField.isEnabled = false
            userNameTextField.isUserInteractionEnabled = false
            userNameTextField.text = profile?.username
            nameTextField.text = profile?.name
            lastNameTextField.text = profile?.lastname
            emailTextField.text = profile?.email
        }
    }
    
    // Default native Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let config = configuration else {
            
            // TODO: Logger
            print("No configuration!!!")
            self.dismiss(animated: true)
            
            return
        }
        
        loadEditorConfiguration(configuration: config)
    }
}
