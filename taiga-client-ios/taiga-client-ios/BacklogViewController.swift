//
//  BacklogViewController.swift
//  taiga-client-ios
//
//  Created by Michael Rockenschaub on 27/02/2017.
//  Copyright © 2017 r31r0c. All rights reserved.
//

import UIKit

class BacklogViewController: UIViewController {

    @IBOutlet weak var userStoriesTableView: UITableView!
    @IBOutlet weak var loadingAnimator: UIActivityIndicatorView!
    
    var userStories: [UserStoryDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userStoriesTableView.dataSource = self
        userStoriesTableView.delegate = self
        userStoriesTableView.rowHeight = UITableViewAutomaticDimension
        userStoriesTableView.estimatedRowHeight = 140
        
        self.tabBarController?.title = TaigaSettings.SELECTED_PROJECT_NAME
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserstoryManager.instance().getUserstoresOfProject(projectId: TaigaSettings.SELECTED_PROJECT_ID) { (userStoryDetails) in
            self.userStories = userStoryDetails
            
            if self.userStories.count > 0 {
                self.userStoriesTableView.reloadData()
                self.userStoriesTableView.backgroundView = nil
            } else {
                let label = UILabel()
                label.textAlignment = .center
                label.text = "Looks empty here."
                self.userStoriesTableView.backgroundView = label
            }
            
            self.loadingAnimator.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = self.userStoriesTableView.indexPathForSelectedRow
        
        if segue.identifier == "segueUserStoryDetail" {
            if let storyDetailsVC = segue.destination as? StoryDetailsViewController, let idx = index {
                storyDetailsVC.userstoryId = userStories[idx.row].id
            }
        }
    }
}

extension BacklogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userstory_cell", for: indexPath) as! UserstoryCell
        
        cell.lblName.text = "#\(userStories[indexPath.row].ref) \(userStories[indexPath.row].subject)"
        cell.lblPoints.text = String(userStories[indexPath.row].totalPoints)
        cell.lblStatus.text = userStories[indexPath.row].statusExtraInfo.name
        cell.lblStatus.textColor = UIColor(hexString: userStories[indexPath.row].statusExtraInfo.color)
        
        return cell
    }
}
