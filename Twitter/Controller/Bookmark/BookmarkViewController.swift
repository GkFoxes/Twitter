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
        
        self.bookmarkTableContent.estimatedRowHeight = 64.0
        self.bookmarkTableContent.rowHeight = UITableView.automaticDimension
        bookmarkTableContent.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableData = tweetRealm.setTableData()
        bookmarkTableContent.reloadData()
        
        print(tableData)
        
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
        
        var information: TweetRealm = TweetRealm();
        information = tableData[indexPath.row] as! TweetRealm

        cell.textTwitLabel.text = information.text
        cell.nameLabel.text = information.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
