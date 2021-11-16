//
//  UsersMainInfoTableViewCell.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 9/20/21.
//

import UIKit

class UsersMainInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    
    var rowUserId: Int!
    var rowUserTitle: String!
    var rowPostId: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.layer.cornerRadius = self.userImage.frame.height / 2
        
    }

    
}
