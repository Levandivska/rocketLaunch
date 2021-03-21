//
//  Network.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import Foundation


class Network {
    
    private let baseURL = "https://lldev.thespacedevs.com/2.2.0/"
    
    func fetchLaunchData(completion: @escaping ([LaunchRocketInfo]?) -> (Void)) {
        
        // TODO add query parameters
        let path = baseURL + "launch/upcoming/?limit=50"
        
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
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let laounchRocketsInfo = try? decoder.decode(LaunchRocketsInfo.self, from: data){
                    DispatchQueue.main.async{
                        completion(laounchRocketsInfo.results)
                    }
                    return
                }
            }
            
            DispatchQueue.main.async{
                completion(nil)
            }
        }
        
        dataTask.resume()
    }
    
    
    func fetchLounchDetail(id: String, completion: @escaping (LaunchRocketDetail?) -> (Void) ){
        let path = baseURL + "launch/upcoming/" + id
        
        guard let url = URL(string: path) else{
            print("invalid Url")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil{
                print("Error: \(String(describing: error))")
                return
            }
            
            if let data = data{
                let decoder = JSONDecoder()
                if let laounchRocketInfo = try? decoder.decode(LaunchRocketDetail.self, from: data){
                    DispatchQueue.main.async{
                        completion(laounchRocketInfo)
                    }
                    return
                }
            }
            
            DispatchQueue.main.async{
                completion(nil)
            }
        }
        
        dataTask.resume()
    }
}
