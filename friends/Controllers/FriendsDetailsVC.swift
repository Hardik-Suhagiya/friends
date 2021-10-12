//
//  FriendsDetailsVC.swift
//  friends
//
//  Created by Hardik's Mac on 12/10/21.
//

import UIKit

class FriendsDetailsVC: UIViewController {
    //MARK: - outlet
    @IBOutlet weak var imgFriend: UIImageView!
    @IBOutlet weak var tblDetails: UITableView!
    
    //MARK: - variable
    var details : Result?
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //setup UI
        self.setupUI()
    }
    
    //MARK: - Setup UI
    func setupUI(){
        
        //Show title
        self.title = "Details"
        
        //register nib of cell
        tblDetails.register(UINib(nibName: "FriendDetailCell", bundle: nil), forCellReuseIdentifier: "FriendDetailCell")
        
        //remove extra seperators
        tblDetails.tableFooterView = UIView()
        
        //show image
        imgFriend.loadImageUsingCache(withUrl: details?.picture?.thumbnail ?? "")
    }
}

extension FriendsDetailsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendDetailCell", for: indexPath) as! FriendDetailCell
        switch indexPath.row {
        case 0: // Full name
            cell.lblTitle.text = "Name"
            
            var name = ""
            if details?.name?.title != ""
            {
                name.append(details?.name?.title ?? "")
                name.append(".")
            }
            if details?.name?.first != ""
            {
                name.append(details?.name?.first ?? "")
                name.append(" ")
            }
            if details?.name?.last != ""
            {
                name.append(details?.name?.last ?? "")
            }
            cell.lblValue.text = name
            break
        case 1: // Address
            cell.lblTitle.text = "Address"
            if ((details?.location?.street?.number) != nil) {
                cell.lblValue.text = "\(String(describing: details?.location?.street?.number!))" + (details?.location?.street?.name ?? "")
            }
            else{
                cell.lblValue.text = (details?.location?.street?.name ?? "")
            }
            
            break
        case 2: // City
            cell.lblTitle.text = "City"
            cell.lblValue.text = details?.location?.city
            break
        case 3: // State
            cell.lblTitle.text = "State"
            cell.lblValue.text = details?.location?.state
            break
        case 4: // Country
            cell.lblTitle.text = "Country"
            cell.lblValue.text = details?.location?.country
            break
        case 5: // Email
            cell.lblTitle.text = "Email"
            cell.lblValue.text = details?.email
            break
        case 6: // Cell phone
            cell.lblTitle.text = "Cell phone"
            cell.lblValue.text = details?.cell
            break
        default:
            cell.lblTitle.text = ""
            cell.lblValue.text = ""
            break
        }
        return cell
    }
    
    
}
