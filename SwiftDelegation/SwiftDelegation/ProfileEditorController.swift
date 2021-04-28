//
//  ProfileEditorController.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import UIKit

class ProfileEditorController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileEditActionButton: UIButton!
    
    @IBAction func profileEditAction(_ sender: UIButton) {
        
        // Potential usecase for a Delegation pattern for the behavior of cell configuration with Profile class
        guard ProfileEditorController.verifyFormatFor(username: userNameTextField.text ?? "") else {
            return
        }
        
        guard ProfileEditorController.verifyFormatFor(name: nameTextField.text ?? "") else {
            return
        }
        
        guard ProfileEditorController.verifyFormatFor(lastName: lastNameTextField.text ?? "") else {
            return
        }
        
        guard ProfileEditorController.verifyFormatFor(email: emailTextField.text ?? "") else {
            return
        }
        
        let editedProfile = Profile(username: userNameTextField.text ?? "",
                              name: nameTextField.text ?? "",
                              lastname: lastNameTextField.text ?? "",
                              email: emailTextField.text ?? "")
        
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
    
    @IBAction func profileCancelAction(_ sender: UIButton) {
        
        if configuration == .create {
            self.performSegue(withIdentifier: "edu.bu.chriswgm.UIStoryboardSegue.unwind.profiles", sender: self)
        }
        
        if configuration == .update {
            self.dismiss(animated: true)
        }
    }
    
//    var validatorDelegate: ProfileDataVerificationDelegate?
    
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
    
    var configuration: EditorConfiguration?
    
    var profile: Profile?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        validatorDelegate = ProfileDataValidator()
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // Potential usecase for a Delegation pattern for the behavior of cell configuration with Profile class
    static func verifyStandartFormat(verstr: String) -> Bool {
        
        let cleanValue = verstr.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !cleanValue.isEmpty else {
            return false
        }
        
        guard cleanValue.count > 2 else {
            return false
        }
        
        if cleanValue.first?.isNumber ?? false {
            return false
        }
        
        return true
    }
    
    // Potential usecase for a Delegation pattern for the behavior of cell configuration with Profile class
    static func verifyFormatFor(username: String) -> Bool {
        
        guard verifyStandartFormat(verstr: username) else {
            return false
        }
        
        guard username.count > 6 else {
            return false
        }
        
        guard !username.contains(where: { $0.isSymbol }) else {
            return false
        }
        
        guard !username.contains(where: { $0.isPunctuation }) else {
            return false
        }
        
        return true
    }
    
    // Potential usecase for a Delegation pattern for the behavior of cell configuration with Profile class
    static func verifyFormatFor(name: String) -> Bool {
        
        guard verifyStandartFormat(verstr: name) else {
            return false
        }
        
        guard !name.contains(where: { $0.isSymbol }) else {
            return false
        }
        
        return true
    }
    
    // Potential usecase for a Delegation pattern for the behavior of cell configuration with Profile class
    static func verifyFormatFor(lastName: String) -> Bool {
        
        guard verifyStandartFormat(verstr: lastName) else {
            return false
        }
        
        guard !lastName.contains(where: { $0.isSymbol }) else {
            return false
        }
        
        return true
    }
    
    // Potential usecase for a Delegation pattern for the behavior of cell configuration with Profile class
    static func verifyFormatFor(email: String) -> Bool {
        
        guard verifyStandartFormat(verstr: email) else {
            return false
        }
        
        guard email.filter({ $0 == "@" }).count == 1 else {
            return false
        }
        
        return true
    }
}
