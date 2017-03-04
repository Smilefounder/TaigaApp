//
//  StoryDetailsViewController.swift
//  taiga-client-ios
//
//  Created by Michael Rockenschaub on 02/03/2017.
//  Copyright © 2017 r31r0c. All rights reserved.
//

import UIKit

class StoryDetailsViewController: UIViewController {
    var userstory: UserStoryDetail?
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var lblCreated: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAssignedTo: UILabel!
    @IBOutlet weak var lblTotalPoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let details = userstory {
            lblName.text = details.subject
            
            if details.description.isEmpty {
                textDescription.text = "No description"
            } else {
                textDescription.text = details.description
            }
            
            lblCreated.text = details.createdDate
            lblStatus.text = details.statusExtraInfo.name
            if details.assignedTo.isEmpty {
                lblAssignedTo.text = "Not assigned"
            } else {
                lblAssignedTo.text = details.assignedTo
            }
            lblTotalPoints.text = "\(details.totalPoints) total points"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
