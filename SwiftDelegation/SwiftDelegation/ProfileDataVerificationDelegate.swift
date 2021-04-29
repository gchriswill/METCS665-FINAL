//
//  ProfileDataVerificationDelegate.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import Foundation

protocol ProfileDataVerificationDelegate {
    var profile: Profile! {get}
    func validate(profile: Profile) -> Bool
    func verifyStandartFormat(verstr: String) -> Bool
    func verifyUsernameFormat() -> Bool
    func verifyNameFormat() -> Bool
    func verifyLastnameFormat() -> Bool
    func verifyEmailFormat() -> Bool
}

extension ProfileDataVerificationDelegate {
    /**
     The following functions are for data validation based on rules that where gathered from the assumptions list
     */
    // Potential usecase for a Delegation pattern
    func verifyStandartFormat(verstr: String) -> Bool {

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

//    // Potential usecase for a Delegation pattern
//    static func verifyFormatFor(username: String) -> Bool {
//
//        guard verifyStandartFormat(verstr: username) else {
//            return false
//        }
//
//        guard username.count >= 6 else {
//            return false
//        }
//
//        guard !username.contains(where: { $0.isSymbol }) else {
//            return false
//        }
//
//        guard !username.contains(where: { $0.isPunctuation }) else {
//            return false
//        }
//
//        return true
//    }
//
//    // Potential usecase for a Delegation pattern
//    static func verifyFormatFor(name: String) -> Bool {
//
//        guard verifyStandartFormat(verstr: name) else {
//            return false
//        }
//
//        guard !name.contains(where: { $0.isSymbol }) else {
//            return false
//        }
//
//        return true
//    }
//
//    // Potential usecase for a Delegation pattern
//    static func verifyFormatFor(lastName: String) -> Bool {
//
//        guard verifyStandartFormat(verstr: lastName) else {
//            return false
//        }
//
//        guard !lastName.contains(where: { $0.isSymbol }) else {
//            return false
//        }
//
//        return true
//    }
//
//    static func verifyFormatFor(email: String) -> Bool {
//
//        guard verifyStandartFormat(verstr: email) else {
//            return false
//        }
//
//        guard email.filter({ $0 == "@" }).count == 1 else {
//            return false
//        }
//
//        return true
//    }
}
