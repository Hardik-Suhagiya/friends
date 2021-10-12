//
//  FriendListCell.swift
//  friends
//
//  Created by Hardik's Mac on 12/10/21.
//

import UIKit

class FriendListCell: UITableViewCell {
    
    //MARK: - outlet
    @IBOutlet weak var imgFriendPhoto: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
