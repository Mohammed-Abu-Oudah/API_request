

import UIKit

class SentPostDataViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var bodyTextField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        

    }
    
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        if (titleTextField.text.isEmpty == true) || (bodyTextField.text.isEmpty == true) {
            let alertController = UIAlertController(title: "Add A title and a message to submit", message: "Hello", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true)
            
        }else{
            
            let alertController = UIAlertController(title: "Confirm Posting", message: "Hello", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
                
                let message = PostMessage(title: self.titleTextField.text, body: self.bodyTextField.text)
                let postRequest = APIPostRequest()
                
                postRequest.save(message, completion: { result in
                    
                    switch result{
                    case .success(let message):
                        print("The following message has been sent: \(String(describing: message.body))")
                        
                    case.failure(let error):
                        print("An error occurred: \(error)")
                    }
                    
                })
                
            }))
            self.present(alertController, animated: true)
            
        }
        
        
    }
    
}
