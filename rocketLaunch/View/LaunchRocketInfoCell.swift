//
//  LaunchRocketInfoCell.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import UIKit

class LaunchRocketInfoCell: UITableViewCell {
    
    @IBOutlet weak var rocketName: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var windowStart: UILabel!
    
    @IBOutlet weak var windowEnd: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    static let identifier = "LaunchRocketInfo"
    
    func configure(with launchInfo: LaunchRocketInfo){
        rocketName.text = "name: " + launchInfo.name
        status.text = "status: " + launchInfo.status.name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y, MMM d, HH:mm:ss"
        windowStart.text = "window start: " + formatter.string(from: launchInfo.windowStart)
        windowEnd.text = "window end: " + formatter.string(from: launchInfo.windowEnd)
    }

    
}
