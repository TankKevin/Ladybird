//
//  MediaViewController.swift
//  Worm
//
//  Created by 谭凯文 on 2018/4/3.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import UIKit

class MediaViewController: UITableViewController {
    
    var mediaType: MediaType!
    
    var mediaStore: MediaStore! = MediaStore()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaStore.allMedias.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath)
        
        
        cell.textLabel?.text = "" + mediaStore.allMedias[indexPath.row].name
        cell.detailTextLabel?.text = "NO.\(mediaStore.allMedias.count - indexPath.row)   " + mediaStore.allMedias[indexPath.row].date
        return cell
    }
    
    
    // TODO: - Reload the table when swiped down
//    @IBAction func reloadTableView(sender: AnyObject) {
//        tableViewReloadAndHandleZero()
//
//    }
    
    @IBAction func unwindToMediaViewControllerWith(segue: UIStoryboardSegue) {
        
        let accountController = segue.source as! AccountViewController
        if let text = accountController.idTextField.text, let id = Int(text) {
            // Write
            let nsArray = NSArray(array: ["\(id)"])
            let filePath = NSHomeDirectory() + "/Documents/account.plist"
            nsArray.write(toFile: filePath, atomically: true)
            
            
            // Read
            if let nsArray = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/account.plist"), nsArray.count > 0 {
                let  accountStr = nsArray.lastObject as! String
                
                
                tableViewReloadAndHandleZero(id: Int(accountStr)!)
                
                
            } else {
                print("Invalid file path or no account.")
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Determine which type the view controller is
        switch (navigationController?.tabBarItem.title)! {
        case "电影":
            self.mediaType = .movie
        case "书籍":
            self.mediaType = .book
        case "音乐":
            self.mediaType = .music
        default:
            fatalError()
        }
        navigationItem.title = (navigationController?.tabBarItem.title)!
        
        
        // Read from file
        if let nsArray = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/account.plist"), nsArray.count > 0 {
            
            
            let  accountStr = nsArray.lastObject as! String
            
            
            tableViewReloadAndHandleZero(id: Int(accountStr)!)
        } else {
            
            
            // Present the account view controller
            self.performSegue(withIdentifier: "presentAccount", sender: nil)
            
            
            
            
        }

        
        
        
    }
    
    @IBAction func refreshTableView(sender: AnyObject?) {
        // Read from file
        if let nsArray = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/account.plist"), nsArray.count > 0 {
            
            
            let  accountStr = nsArray.lastObject as! String
            
            
            tableViewReloadAndHandleZero(id: Int(accountStr)!)
        } else {
            
            
            // Present the account view controller
            self.performSegue(withIdentifier: "presentAccount", sender: nil)
            
        }
    }
    
    func tableViewReloadAndHandleZero(id: Int) {
        do {
            mediaStore = try MediaStore(doubanID: id, mediaType: mediaType)
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
        
        if tableView.numberOfRows(inSection: 0) == 0 {
            tableView.separatorStyle = .none
            tableView.rowHeight = 60
            
            tableView.isScrollEnabled = false
            
        }


    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        refreshTableView(sender: nil)
//    }
    
    // TODO: - 下拉加载更多
    
    // segue to detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "showDetail" {
            let destination = segue.destination as! DetailViewController
            destination.media = mediaStore.allMedias[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }
    
}
