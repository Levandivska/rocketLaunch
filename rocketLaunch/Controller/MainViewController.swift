//
//  ViewController.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var network = Network()
    
    var launchRocketsInfo: [LaunchRocketInfo] = []
    var filteredResults: [LaunchRocketInfo] = []
    var favoritesId: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        let defaults = UserDefaults.standard
        
        network.fetchLaunchData{ [weak self] (launchInfo) -> (Void) in
            if let launchInfo = launchInfo {
                self?.launchRocketsInfo = launchInfo
                self?.filteredResults = launchInfo
                self?.favoritesId = defaults.object(forKey: "Favorites") as? [String] ?? [String]()
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let indexPath = tableView.indexPathForSelectedRow,
           let detailVC = segue.destination as? DetailViewController{
            detailVC.launchId = filteredResults[indexPath.row].id
        }
    }
    
    func filterResultsByName(name: String){
        filteredResults = launchRocketsInfo.filter{$0.name.starts(with: name)}
    }
    
    // change isFavorite status of cell and return new isFavorite status
    func changeIsFavoriteStatusOfLaunch(id: String) -> Bool{
        if favoritesId.contains(id){
            favoritesId = favoritesId.filter {$0 != id}
            UserDefaults.standard.set(self.favoritesId, forKey: "Favorites")
            return false
        }
        
        favoritesId.append(id)
        UserDefaults.standard.set(self.favoritesId, forKey: "Favorites")
        return true
    }
    
    func launchIsFavorite(id: String) -> Bool{
        return favoritesId.contains(id)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchRocketInfoCell.identifier, for: indexPath) as! LaunchRocketInfoCell
                
        cell.delegate = self
        
        let launchInfo = filteredResults[indexPath.row]
        cell.isFavorite = launchIsFavorite(id: launchInfo.id)
        cell.configure(with: launchInfo)
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
        let launchId = filteredResults[indexPathRow].id
        let isFavoriteNewStatus = changeIsFavoriteStatusOfLaunch(id: launchId)
        tuppedButtonInCell.isFavorite = isFavoriteNewStatus
        tableView.reloadData()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange: String){
        if textDidChange.isEmpty {
            self.filteredResults = self.launchRocketsInfo
        } else{
            filterResultsByName(name: textDidChange)
        }
        tableView.reloadData()
    }
}
