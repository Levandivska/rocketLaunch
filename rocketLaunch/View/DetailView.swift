////
////  DetailView.swift
////  rocketLaunch
////
////  Created by оля on 21.03.2021.
////
//
//import UIKit
//
//class DetailView: UIView {
//
////    @IBOutlet weak var rocketName: UILabel!
////
////    @IBOutlet weak var rocketDescription: UILabel!
////    
////    @IBOutlet weak var rocketDiameter: UILabel!
////
////    @IBOutlet weak var rocketLength: UILabel!
////
////    @IBOutlet weak var padName: UILabel!
////
////    @IBOutlet weak var padWikiUrl: UILabel!
////
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    func updateUI(with launchDetail: LaunchRocketDetail){
//        rocketName?.text = "name: " + launchDetail.rocket.configuration.name
//        rocketDescription?.text = "description: " + launchDetail.rocket.configuration.description
//        rocketLength?.text = "length: " + String(launchDetail.rocket.configuration.length) + " m"
//        rocketDiameter?.text = "diameter: " + String(launchDetail.rocket.configuration.diameter) + " m"
//        padName?.text = "name: " + launchDetail.pad.name
//        padWikiUrl?.text = "wiki url: " + launchDetail.pad.wikiUrl
//    }
//}
