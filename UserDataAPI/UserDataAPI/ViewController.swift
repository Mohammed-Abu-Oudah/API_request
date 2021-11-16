//
//  ViewController.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 9/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usersTable: UITableView!
    
    
    var listOfUsers = [UserData](){
        
        didSet{
            
            DispatchQueue.main.async {
                self.usersTable.reloadData()
                self.navigationItem.title = "\(self.listOfUsers.count) users found"
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "UsersMainInfoTableViewCell", bundle: nil)
        usersTable.register(cellNib, forCellReuseIdentifier: "UsersMainInfoTableViewCell")
        
        
        let userDataRequest = UserDataRequest()
        userDataRequest.returnData{ [weak self] result in
            
            switch result{
            case .failure(let error):
                print(error)
            case.success(let info):
                self?.listOfUsers = info
            }
            
        }
        
        
    }

    @IBAction func addAnotherPostPressed(_ sender: Any) {
        let destinationVC = self.storyboard?.instantiateViewController(identifier: "SentPostDataViewController") as! SentPostDataViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    

}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersMainInfoTableViewCell", for: indexPath) as! UsersMainInfoTableViewCell
        let currentUser = listOfUsers[indexPath.row]
        cell.rowUserId = currentUser.userId
        cell.rowUserTitle = currentUser.title
        cell.rowPostId = currentUser.id
        cell.userId.text = "UserId: \(currentUser.userId)"
        cell.userTitle.text = "Title: \(currentUser.title)"
        cell.userImage.backgroundColor = UIColor.init(red: CGFloat((5 * currentUser.userId)) / 255, green: CGFloat((15 * currentUser.userId)) / 255, blue: CGFloat((10 * currentUser.userId)) / 255, alpha: 1)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // let cell = tableView.dequeueReusableCell(withIdentifier: "UsersMainInfoTableViewCell", for: indexPath) as! UsersMainInfoTableViewCell
        let currentUser = listOfUsers[indexPath.row]

        let destinationVc = self.storyboard?.instantiateViewController(withIdentifier: "PostInfoVC") as! PostInfoVC
        
        destinationVc.rowId = String(describing: currentUser.userId)
        destinationVc.rowPostId = currentUser.id
        destinationVc.userImageBackground = UIColor.init(red: CGFloat((5 * currentUser.userId)) / 255, green: CGFloat((15 * currentUser.userId)) / 255, blue: CGFloat((10 * currentUser.userId)) / 255, alpha: 1)
        destinationVc.rowDescribtion = currentUser.title
        destinationVc.postBody = currentUser.body
        
        self.navigationController?.pushViewController(destinationVc, animated: true)

        
    }
    
    
}



extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
