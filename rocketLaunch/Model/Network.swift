//
//  Network.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import Foundation


class Network {
    
    
    private let baseURL = "https://ll.thespacedevs.com/2.0.0/"
    
    // fetch name of laounch, status and launch windows
    func fetchLaunchData(){
        let path = baseURL + "launch/"
        guard let url = URL(string: path) else {
            print("Invalid Url")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil{
                print("Error: \(String(describing: error))")
                return
            }
            if let data = data{
                if let decodedJson = try? JSONDecoder().decode(LaunchRocketsInfo.self, from: data){
                    print(decodedJson)
                }
            }

        }
        
        dataTask.resume()
    }
    
}
