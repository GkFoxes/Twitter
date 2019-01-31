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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarkTableContent.rowHeight = UITableView.automaticDimension
        bookmarkTableContent.estimatedRowHeight = 60
        bookmarkTableContent.tableFooterView = UIView(frame: CGRect.zero)
        
        tableData = tweetRealm.setTableData()
        bookmarkTableContent.reloadData()
        print(tableData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Cancel Side Menu swipe
        //let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //appDelegate?.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone
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
        
//        let tweetRealm: TweetRealm = TweetRealm();
//
//        var information: TweetRealm = TweetRealm();
//        information = tableData[indexPath.row]
//
//        cell.nameLabel.text = userIndex?.name()
//        var handleStr = "@"
//        handleStr = handleStr + (userIndex?.handle() ?? "")
//        cell?.usernameLabel.text = handleStr
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
