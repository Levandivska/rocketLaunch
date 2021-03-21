//
//  LaunchRocketInfoCell.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import UIKit

class LaunchRocketInfoCell: UITableViewCell {

    static let identifier = "LaunchRocketInfo"

    @IBOutlet weak var rocketName: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var windowStart: UILabel!
    
    @IBOutlet weak var windowEnd: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    var isFavorite = false
        
    weak var delegate : LaunchRocketInfoCellDelegate? = nil

    func configure(with launchInfo: LaunchRocketInfo){
        rocketName.text = "name: " + launchInfo.name
        status.text = "status: " + launchInfo.status.name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y, MMM d, HH:mm:ss"
        windowStart.text = "window start: " + formatter.string(from: launchInfo.windowStart)
        windowEnd.text = "window end: " + formatter.string(from: launchInfo.windowEnd)
        
        // Dont repeat yorself
        let buttonImage = UIImage(systemName: "heart.fill")
        heartButton.setImage(buttonImage, for: .normal)
        
        if isFavorite{
            let buttonImage = UIImage(systemName: "heart.fill")
            heartButton.setImage(buttonImage, for: .normal)
        }else{
            let buttonImage = UIImage(systemName: "heart")
            heartButton.setImage(buttonImage, for: .normal)
        }
        
    }
    
    @IBAction func launchButtonTapped(_ sender: UIButton) {
        self.delegate?.launchRocketTableViewCell(self)
    }
}

protocol LaunchRocketInfoCellDelegate: AnyObject {
  func launchRocketTableViewCell(_ tuppedButtonInCell: LaunchRocketInfoCell)
}
