//
//  Profile.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import Foundation

/**
 The class `Profile` is the model object for holding the user's data and the model type to store as encoded data.
 */
class Profile: NSObject, Codable {
    
    // Variables for to hold each data point of the collected information from the user.
    var username: String, name: String, lastname: String, email: String
    
    // Initializer requirement as Codable conformance
    required init?(coder: NSCoder) {
        
        self.username = coder.decodeObject(forKey: "username") as? String ?? ""
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.lastname = coder.decodeObject(forKey: "lastname") as? String ?? ""
        self.email = coder.decodeObject(forKey: "email") as? String ?? ""
    }
    
    /**
     Custom initializer with parameters as required values of the initialization
     */
    init(username: String, name: String, lastname: String, email: String) {
        
        self.username = username
        self.name = name
        self.lastname = lastname
        self.email = email
        
        super.init()
    }
    
    /**
     A fuction requirement as Codable conformance
     */
    func encode(with coder: NSCoder) {
        
        coder.encode(username, forKey: "username")
        coder.encode(name, forKey: "name")
        coder.encode(lastname, forKey: "lastname")
        coder.encode(email, forKey: "email")
    }
    
    /**
     Overrriding comparison function for checking the equality of just the `username` data point
     */
    override func isEqual(_ object: Any?) -> Bool {
        
        guard let profileObject = object as? Profile else {
            return false
        }
        
        guard self.username == profileObject.username else {
            return false
        }
        
        return true
    }
}
