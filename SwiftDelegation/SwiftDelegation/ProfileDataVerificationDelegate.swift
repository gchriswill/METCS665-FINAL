//
//  ProfileDataVerificationDelegate.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import Foundation

public protocol ProfileDataVerificationDelegate {
    static func verifyFormatFor(username: String) -> Bool
    static func verifyFormatFor(name: String) -> Bool
    static func verifyFormatFor(lastName: String) -> Bool
    static func verifyFormatFor(email: String) -> Bool
}

public extension ProfileDataVerificationDelegate {
    
    private static func verifyStandartFormat(verstr: String) -> Bool {
        
        let cleanValue = verstr.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !cleanValue.isEmpty else {
            return false
        }
        
        guard cleanValue.count > 2 else {
            return false
        }
        
        guard cleanValue.first?.isNumber ?? false else {
            return false
        }
        
        return true
    }
    
    static func verifyFormatFor(username: String) -> Bool {
        
        guard verifyStandartFormat(verstr: username) else {
            return false
        }
        
        guard username.count > 8 else {
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
    
    static func verifyFormatFor(name: String) -> Bool {
        
        guard verifyStandartFormat(verstr: name) else {
            return false
        }
        
        guard !name.contains(where: { $0.isSymbol }) else {
            return false
        }
        
        return true
    }
    
    static func verifyFormatFor(lastName: String) -> Bool {
        
        guard verifyStandartFormat(verstr: lastName) else {
            return false
        }
        
        guard !lastName.contains(where: { $0.isSymbol }) else {
            return false
        }
        
        return true
    }
    
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
