//
//  SwiftDelegationTests.swift
//  SwiftDelegationTests
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import XCTest
@testable import SwiftDelegation

/**
 A test class for testing the CRUD functionality of the app
 */
class SwiftDelegationTests: XCTestCase {
    
    var profiles = [Data]()
    var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var editor: ProfileEditorController?
    var viewer: ProfileViewerController?
    var usernames = ["testusername1", "testusername2"]
    
    
    // This method is called before the invocation of each test method in the class.
    override func setUpWithError() throws {
        
        if editor == nil, let evc = storyboard.instantiateViewController(withIdentifier: "ProfileEditorController") as? ProfileEditorController {
            editor = evc
        }
        
        if viewer == nil, let vvc = storyboard.instantiateViewController(withIdentifier: "ProfileViewerController") as? ProfileViewerController {
            viewer = vvc
        }
    }

    // This method is called after the invocation of each test method in the class.
    override func tearDownWithError() throws {
        
        profiles = [Data]()
        UserDefaults.standard.setValue(profiles, forKey: ProfilesTableViewController.keyId)
    }

    // This method test the creation feature of a profile
    func testCreateProfile() throws {
        
        editor?.configuration = .create
        
        editor?.userNameTextField = UITextField()
        
        if (profiles.isEmpty) {
            editor?.userNameTextField.text = usernames.first
        } else {
            editor?.userNameTextField.text = usernames.last
        }
        
        editor?.nameTextField = UITextField()
        editor?.nameTextField.text = "testname"
        
        editor?.lastNameTextField = UITextField()
        editor?.lastNameTextField.text = "testlastname"
        
        editor?.emailTextField = UITextField()
        editor?.emailTextField.text = "testemail@test.com"

        editor?.profileEditAction(UIButton())

        profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
    
        XCTAssert(profiles.count > 0)
    }
    
    // This method test the profile update feature
    func testUpdateProfile() throws {
        
        try? testCreateProfile()
        
        editor?.configuration = .update
        
        guard let profileData = profiles.first,
              let profile = try? JSONDecoder().decode(Profile.self, from: profileData) else {
            
            XCTAssert(false)
            return
        }
        
        editor?.profile = profile
        
        editor?.userNameTextField.text = profile.username
        editor?.nameTextField.text = profile.name
        editor?.lastNameTextField.text = profile.lastname
        editor?.emailTextField.text = profile.email
        
        editor?.nameTextField.text = "testname_updated"
        editor?.profileEditAction(UIButton())
        
        profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
        
        XCTAssert(profiles.count == 1)
        
        guard let profileDataUpdated = profiles.first,
              let profileUpdated = try? JSONDecoder().decode(Profile.self, from: profileDataUpdated) else {
            
            XCTAssert(false)
            return
        }
        
        XCTAssert(profileUpdated.name == "testname_updated")
    }
    
    // This method test the deletion feature of a profile
    func testDeleteProfile() throws {
        
        try? testCreateProfile()
        
        guard let profileData = profiles.first,
              let profile = try? JSONDecoder().decode(Profile.self, from: profileData) else {
            
            XCTAssert(false)
            return
        }
        
        viewer?.profile = profile
        
        viewer?.deleteProfile()
        
        profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
        
        XCTAssert(profiles.isEmpty)
    }
    
    // This method test the deletion feature of all profiles
    func testClearAll() throws {
        
        try? testCreateProfile()
        try? testCreateProfile()
        
        XCTAssert(!profiles.isEmpty, "SwiftDelegationTests > testClearAll: Couldn't create the profiles")
        XCTAssert(profiles.count == 2, "SwiftDelegationTests > testClearAll: profiles count doesn't equal 2")
        
        guard let tvc = storyboard.instantiateViewController(withIdentifier: "ProfilesTableViewController") as? ProfilesTableViewController else {
            XCTAssert(false, "SwiftDelegationTests > testClearAll: Cannot invoke ProfilesTableViewController class")
            return
        }
        
        tvc.clearAllAction(UIBarButtonItem())
        
        profiles = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
        
        XCTAssert(profiles.isEmpty, "SwiftDelegationTests > testClearAll: Couldn't delete all the profiles")
    }
}
