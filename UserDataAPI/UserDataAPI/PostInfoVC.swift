//
//  PostInfoVC.swift
//  UserDataAPI
//
//  Created by Eng-Mohammed Abu Oudah on 9/27/21.
//

import UIKit

class PostInfoVC: UIViewController {
    
    @IBOutlet weak var userImageView: UIView!
    @IBOutlet weak var userIdView: UIView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var postTitleView: UIView!
    @IBOutlet weak var postTitleText: UITextView!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var commentsTableView: UIView!
    @IBOutlet weak var addCommentBtn: UIButton!
    @IBOutlet weak var newCommentView: UIView!
    @IBOutlet weak var newCommentTxtField: UITextView!
    
    
    
    var rowId : String = ""
    var userImageBackground  = UIColor.init(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1)
    var rowDescribtion = ""
    var rowPostId: Int!
    var postBody: String = ""
    
    
    var listOfComments = [CommentData](){
        
        didSet{
            DispatchQueue.main.async {
                self.commentsTable.reloadData()
                self.navigationItem.title = "Post Description"
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // This block of code is to make the a shadow for the postTitleView
        commentsTableView.layer.shadowRadius = 10
        commentsTableView.layer.shadowOpacity = 0.8
        commentsTableView.layer.shadowColor = UIColor.lightGray.cgColor
        // And this one is to make the shadow only for the button part
        commentsTableView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                   y:commentsTableView.layer.bounds.minY - commentsTableView.layer.shadowRadius,
                                                                   width:commentsTableView.bounds.width,
                                                                   height: commentsTableView.layer.shadowRadius)).cgPath
        
        userImageView.backgroundColor = userImageBackground
        userIdLabel.text = "User id: #\(rowId)"
        postTitleText.text = postBody
        postTitleText.isEditable = false
        
        
        addCommentBtn.layer.cornerRadius = addCommentBtn.frame.height / 2
        

        let cellNib = UINib(nibName: "PostCommentsTableViewCell", bundle: nil)
        commentsTable.register(cellNib, forCellReuseIdentifier: "PostCommentsTableViewCell")
        
        let commentDataRequest = CommentDataRequest(forPostId: self.rowPostId)
        commentDataRequest.returnCommentData{ [weak self] result in
            
            switch result{
            case .failure(let error):
                print(error)
            case.success(let info):
                self?.listOfComments = info
            }
            
        }
        
        
    }
    
    
    @IBAction func commetBtnPressed(_ sender: Any) {
        
        if (newCommentTxtField.text.isEmpty == true){
            let alertController = UIAlertController(title: "Enter a comment please", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true)
        }else{
            let alertController = UIAlertController(title: "Confirm commenting", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
                
                let comment = CommentData.init(postId: self.rowPostId, id: self.listOfComments.count + 1 , name: "Mohammed Abu Oudah", email: "medo.doood2211@gmail.com", body: self.newCommentTxtField.text)
                // I made the following variable so it acts as a bridge when I want to add the comment to the current comments list. since the comment type is cosidered to be different than the commentData type.
                
                
                let postCommentRequest = CommentAPIPostRequest()
                
                postCommentRequest.comment(comment, completion: { result in
                    switch result{
                    case .success(let comment):
                        print("The following comment has been posted: \(String(describing: comment.body))")
             
                        self.listOfComments.append(comment)
                        
                        // This is to enable me to alter at the main queue since just reloading data will cause me an error
                        DispatchQueue.main.async {
                            self.commentsTable.reloadData()
                        }
                        
                    case .failure(let error):
                        print("An error occurred: \(error)")
                    }
                    
                })
                
            }))
            self.present(alertController, animated: true)
        }
        
    }
    

}

extension PostInfoVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


extension PostInfoVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfComments.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCommentsTableViewCell", for: indexPath) as! PostCommentsTableViewCell
        let currentComment = listOfComments[indexPath.row]
        cell.commenterEmailLbl.text = currentComment.email
        cell.commentText.text = currentComment.body
        cell.commentText.isEditable = false
        return cell
        
    }
    

}
