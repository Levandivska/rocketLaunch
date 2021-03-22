//
//  LaunchRocketInfo.swift
//  rocketLaunch
//
//  Created by оля on 20.03.2021.
//

import Foundation

struct LaunchRocketInfo: Decodable {
    struct Status: Codable{
        var name: String
    }
    
    var id: String
    var name: String
    var status: Status
    var windowStart: Date
    var windowEnd: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, status
        case windowStart = "window_start"
        case windowEnd = "window_end"
    }
}

