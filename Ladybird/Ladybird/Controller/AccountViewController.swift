//
//  AccountViewController.swift
//  Worm
//
//  Created by 谭凯文 on 2018/4/4.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
    @IBOutlet var finishButton: UIBarButtonItem!
    
    @IBOutlet var idTextField: UITextField! {
        didSet {
//            print("idTextField set to \(idTextField)")
        }
    }

    
    
    @IBAction func cancelNewAccount(sender: AnyObject) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setFinishButtonState() {
        
        finishButton.isEnabled = !(idTextField.text! == "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFinishButtonState()

        idTextField.becomeFirstResponder()
        if let nsArray = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/account.plist"), nsArray.count > 0 {
            let  accountStr = nsArray.lastObject as! String
            
            idTextField.text = accountStr
            finishButton.isEnabled = true
        } else {
            print("Invalid file path or no account.")
        }
        
    }
    
    
    
}
