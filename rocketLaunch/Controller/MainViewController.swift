//
//  ViewController.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    var network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello")
        
        network.fetchLaunchData()
    
        // Do any additional setup after loading the view.
    }


}

