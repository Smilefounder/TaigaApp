//
//  AssignedToExtraInfo.swift
//  taiga-client-ios
//
//  Created by Michael Rockenschaub on 02/03/2017.
//  Copyright © 2017 r31r0c. All rights reserved.
//

import SwiftyJSON

public class AssignedToExtraInfo {
    let fullNameDisplay: String
    
    init(json: JSON) {
        fullNameDisplay = json["full_name_display"].stringValue
    }
}
