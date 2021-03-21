//
//  LaunchRocketDetail.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import Foundation

struct LaunchRocketDetail: Decodable{
    
    struct RocketDetail: Decodable{

        struct Configuration: Decodable{
            var name: String
            var description: String
            var diameter: Double
            var length: Double
//            var launchCost: Int
            
            enum CodingKeys: String, CodingKey{
                case description, diameter, length
                case name = "full_name"
//                case launchCost = "launch_cost"
            }
        }
        
        var configuration: Configuration
    }
    
    struct Pad: Decodable{
        var name: String
        var wikiUrl: String
        
        enum CodingKeys: String, CodingKey{
            case name
            case wikiUrl = "wiki_url"
        }
    }
    
    var rocket: RocketDetail
    var pad: Pad
}
