//
//  ProfileDataValidator.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/20/21.
//

import UIKit
/**
 DELEGATION COMPONENT: The delegate/validator object.
 
 A class for handling the delegated validation/verification behaviour required  for the `ProfileEditorController`.
 The `ProfileDataVerificationDelegate` is the interfacte which declares the behavior we are delegating to this object.
 This object impelements the behavior conforming with the needs of the controller that is delegating the behavior.
 */
class ProfileDataValidator: NSObject, ProfileDataVerificationDelegate {
    
    var profile: Profile!
    
    /**
     The following functions are for data validation based on rules that where gathered from the assumptions list
     */
    
    func validate(profile: Profile) -> Bool {
        self.profile = profile
        return verifyUsernameFormat() && verifyNameFormat() && verifyLastnameFormat() && verifyEmailFormat()
    }

    // A method for verifying the username of the profile prior to create/update
    func verifyUsernameFormat() -> Bool {
        
        guard verifyStandartFormat(verstr: profile.username) else {
            return false
        }
        
        guard profile.username.count >= 6 else {
            return false
        }

        guard !profile.username.contains(where: { $0.isSymbol }) else {
            return false
        }

        guard !profile.username.contains(where: { $0.isPunctuation }) else {
            return false
        }

        return true
    }

    // A method for verifying the name of the profile prior to create/update
    func verifyNameFormat() -> Bool {
        
        guard verifyStandartFormat(verstr: profile.name) else {
            return false
        }

        guard !profile.name.contains(where: { $0.isSymbol }) else {
            return false
        }

        return true
    }

    // A method for verifying the last name of the profile prior to create/update
    func verifyLastnameFormat() -> Bool {

        guard verifyStandartFormat(verstr: profile.lastname) else {
            return false
        }

        guard !profile.lastname.contains(where: { $0.isSymbol }) else {
            return false
        }

        return true
    }

    // A method for verifying the email of the profile prior to create/update
    func verifyEmailFormat() -> Bool {
        
        guard verifyStandartFormat(verstr: profile.email) else {
            return false
        }

        guard profile.email.filter({ $0 == "@" }).count == 1 else {
            return false
        }

        return true
    }
}
