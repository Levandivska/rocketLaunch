//
//  DetailViewController.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var network = Network()
        
    @IBOutlet weak var rocketName: UILabel!
    
    @IBOutlet weak var rocketDescription: UILabel!
    
    @IBOutlet weak var rocketDiameter: UILabel!
    @IBOutlet weak var padName: UILabel!
    var launchId: String? = nil
    
    @IBOutlet weak var rocketLength: UILabel!
    @IBOutlet weak var padWikiUrl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let launchId = launchId else { return }
        
        network.fetchLounchDetail(id: launchId){ [weak self] (launchDetail) -> (Void) in
            guard let self = self,
                  let launchDetail = launchDetail else { return }
            self.rocketName.text = "name: " + launchDetail.rocket.configuration.name
            self.rocketDescription.text = "description: " + launchDetail.rocket.configuration.description
            self.rocketLength.text = "length: " + String(launchDetail.rocket.configuration.length) + " m"
            self.rocketDiameter.text = "diameter: " + String(launchDetail.rocket.configuration.diameter) + " m"
            self.padName.text = "name: " + launchDetail.pad.name
            self.padWikiUrl.text = "wiki url: " + launchDetail.pad.wikiUrl
        }
    }
}
