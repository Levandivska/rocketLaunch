//
//  ViewController.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var network = Network()
    
    var lounchRocketsInfo: [LaunchRocketInfo] = []
    
    var favorites : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        network.fetchLaunchData{ [weak self] (launchInfo) -> (Void) in
            if let launchInfo = launchInfo{
                self?.lounchRocketsInfo = launchInfo
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let indexPath = tableView.indexPathForSelectedRow,
           let detailVC = segue.destination as? DetailViewController{
            detailVC.launchId = lounchRocketsInfo[indexPath.row].id
        }
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton){
        print("heart")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lounchRocketsInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchRocketInfoCell.identifier, for: indexPath) as! LaunchRocketInfoCell
        let cellInfo = lounchRocketsInfo[indexPath.row]
        cell.configure(with: cellInfo)
        return cell
    }
    
    
    
}

