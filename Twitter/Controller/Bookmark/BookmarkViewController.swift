//
//  BookmarkViewController.swift
//  Twitter
//
//  Created by Дмитрий Матвеенко on 31/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    @IBOutlet private weak var bookmarkTableContent: UITableView!
    
    var tableData: [Any] = []
    let tweetRealm: TweetRealm = TweetRealm();
    var information: TweetRealm = TweetRealm();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarkTableContent.delegate = self
        bookmarkTableContent.dataSource = self
        
        self.bookmarkTableContent.rowHeight = UITableView.automaticDimension
        self.bookmarkTableContent.estimatedRowHeight = 64.0
        bookmarkTableContent.tableFooterView = UIView(frame: CGRect.zero)
        bookmarkTableContent.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableData = tweetRealm.setTableData()
        self.bookmarkTableContent.setEditing(false, animated: true)
        bookmarkTableContent.reloadData()
        
        //Cancel Side Menu swipe
        let appDelegate: AppDelegate = AppDelegate();
        appDelegate.cancelSideMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bookmarkTableContent.reloadData()
    }
    
    // MARK: - Delete and edit from table
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            
            self.tableData.remove(at: indexPath.row)
            self.tweetRealm.deleteDataObject(at: Int32(indexPath.row))
            
            self.bookmarkTableContent.deleteRows(at:[indexPath], with: .automatic)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete]
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailBookmarkViewController
        
        let index = bookmarkTableContent.indexPathForSelectedRow?.row
        information = tableData[index!] as! TweetRealm
        
        destinationViewController.text = information.text
        destinationViewController.index = index!
        destinationViewController.information = information
        destinationViewController.tableData = tableData
    }
}
// MARK: - Table View data source

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData.isEmpty {
            return 0
        } else {
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BookmarkCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookmarkTableViewCell
        
        information = tableData[indexPath.row] as! TweetRealm

        cell.textTwitLabel.text = information.text
        cell.nameLabel.text = information.name

        return cell
    }
}
