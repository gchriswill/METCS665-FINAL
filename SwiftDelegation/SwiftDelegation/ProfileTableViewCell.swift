//
//  ProfileTableViewCell.swift
//  SwiftDelegation
//
//  Created by Christopher Gonzalez on 4/19/21.
//

import UIKit

/**
 A Custom subclass to suport reference holding and row customization as the default class brings complexity when
 customizing the views and data and the binders in between
 */
class ProfileTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
