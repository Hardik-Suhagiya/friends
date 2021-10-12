//
//  FriendsListVC.swift
//  friends
//
//  Created by Hardik's Mac on 12/10/21.
//

import UIKit

class FriendsListVC: UIViewController {
    
    //MARK: - outlet
    @IBOutlet weak var tblFriendList: UITableView!
    @IBOutlet weak var viewActivityIndicator: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    //MARK: - variable
    var arrFriends = [Result]()
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //setup UI
        self.setupUI()
        
        // call api for get friend list
        self.getFriendList()
    }
    
    
    //MARK: - Setup UI
    func setupUI(){
        
        //Show title
        self.title = "Friends"
        
        //register nib of cell
        tblFriendList.register(UINib(nibName: "FriendListCell", bundle: nil), forCellReuseIdentifier: "FriendListCell")
        
        //remove extra seperators
        tblFriendList.tableFooterView = UIView()
    }
    
    //MARK: - loader
    func showLoader(){
        DispatchQueue.main.async {
            self.viewActivityIndicator.isHidden = false
            self.activity.startAnimating()
        }
    }
    
    func hideLoader(){
        DispatchQueue.main.async {
            self.viewActivityIndicator.isHidden = true
            self.activity.stopAnimating()
        }
    }
    
    //MARK: - get friend list
    func getFriendList(){
        self.showLoader()
        let webpath = BASE_URL + "results=10"
        var request = URLRequest(url: URL(string: webpath)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            self.hideLoader()
            do {
                let model = try JSONDecoder().decode(FriendListModel.self, from: data!)
                if model.results?.count ?? 0 > 0
                {
                    self.arrFriends = model.results!
                }
                
                DispatchQueue.main.async {
                    self.tblFriendList.reloadData()
                }
                
            } catch {
                debugPrint("error = \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
}

extension FriendsListVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListCell", for: indexPath) as! FriendListCell
        if arrFriends.count > 0{
            //show data
            let frdData = arrFriends[indexPath.row]
            
            //show image
            cell.imgFriendPhoto.loadImageUsingCache(withUrl: frdData.picture?.large ?? "")
            
            //show name
            var name = ""
            if frdData.name?.title != ""
            {
                name.append(frdData.name?.title ?? "")
                name.append(".")
            }
            if frdData.name?.first != ""
            {
                name.append(frdData.name?.first ?? "")
                name.append(" ")
            }
            if frdData.name?.last != ""
            {
                name.append(frdData.name?.last ?? "")
            }
            
            cell.lblName.text = name
            
            //show country
            if frdData.location?.country != ""{
                cell.lblCountry.text = "Country : \(frdData.location?.country ?? "")"
            }
            else{
                cell.lblCountry.text = ""
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigate for view details
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FriendsDetailsVC") as! FriendsDetailsVC
        //send selected data to next page
        vc.details = arrFriends[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

