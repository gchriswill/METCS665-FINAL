//
//  ProfilesTableViewControllerPresenter.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/29/21.
//

import UIKit

/**
 DELEGATION COMPONENT: The delegate/presenter object
 
 A class for handling the delegated behaviour for the presentation of the `ProfileTableViewController`
 The `UIAdaptivePresentationControllerDelegate` is the interfacte which declares the behavior we are delegating to this object.
 This object impelements the behavior conforming with the needs of the controller that is delegating the behavior.
 */
class ProfilesTableViewControllerPresenter: NSObject, UIAdaptivePresentationControllerDelegate {
    
    // A native delegate method that will execute upon the user swipes down to dismiss
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        
        if let profilesController = presentationController.delegate as? ProfilesTableViewController {
            
            let dataArray = UserDefaults.standard.array(forKey: ProfilesTableViewController.keyId) as? [Data] ?? [Data]()
            
            profilesController.dataSource.profiles = dataArray
            profilesController.tableView.reloadData()
        }
    }
}
