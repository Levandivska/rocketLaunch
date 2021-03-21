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
    var favorites: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        let defaults = UserDefaults.standard
        
        network.fetchLaunchData{ [weak self] (launchInfo) -> (Void) in
            if let launchInfo = launchInfo {
                self?.lounchRocketsInfo = launchInfo
                self?.favorites = defaults.object(forKey: "Favorites") as? [Bool] ?? Array(repeating: false, count: launchInfo.count)
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
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lounchRocketsInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchRocketInfoCell.identifier, for: indexPath) as! LaunchRocketInfoCell
                
        cell.delegate = self
        
        cell.isFavorite = favorites[indexPath.row]
        
        let cellInfo = lounchRocketsInfo[indexPath.row]
        cell.configure(with: cellInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension MainViewController: LaunchRocketInfoCellDelegate {
    func launchRocketTableViewCell(_ tuppedButtonInCell: LaunchRocketInfoCell)
    {
        guard let indexPathRow = tableView.indexPath(for: tuppedButtonInCell)?.row else{
            return
        }
        
        let isFavoriteNewStatus = !self.favorites[indexPathRow]
        
        self.favorites[indexPathRow] = isFavoriteNewStatus
        tuppedButtonInCell.isFavorite = isFavoriteNewStatus
        tableView.reloadData()
        
        UserDefaults.standard.set(self.favorites, forKey: "Favorites")
    }
}
