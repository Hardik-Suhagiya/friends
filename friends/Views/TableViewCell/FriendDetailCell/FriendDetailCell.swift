//
//  FriendDetailCell.swift
//  friends
//
//  Created by Hardik's Mac on 12/10/21.
//

import UIKit

class FriendDetailCell: UITableViewCell {
    
    //MARK: -  outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
