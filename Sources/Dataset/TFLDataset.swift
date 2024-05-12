//
//  TFLDataset.swift
//  TFL_App
//
//  Created by Sahil Ak on 11/05/24.
//

import Foundation

struct TFLDataset {
    static var stationsInformation: [String: [Edge]] = [:]
    
    static var trainTimes: [TrainTimeInfo] = []
    
    static func loadData() {
        let url = URL(string: "https://raw.githubusercontent.com/mdsahilak/TFL_Data/main/tfl_data.json")!
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let items = try decoder.decode([TrainTimeInfo].self, from: data)
            
            self.trainTimes = items
            
            // Make station information
            for trainTime in trainTimes {
                let edge = Edge(trainTime.destination, trainTime.time)
                
                if let _ = stationsInformation[trainTime.departure] {
                    stationsInformation[trainTime.departure]!.append(edge)
                } else {
                    stationsInformation[trainTime.departure] = [edge]
                }
            }
        } catch {
            print(error)
        }
        
    }
}

struct TrainTimeInfo: Codable {
    var line: String { line_.uppercased() }
    var direction: String { direction_.uppercased() }
    var departure: String { departure_.uppercased() }
    var destination: String { destination_.uppercased() }
    var time: Double { time_ }
    
    private var line_: String
    private var direction_: String
    private var departure_: String
    private var destination_: String
    private var time_: Double
    
    var description: String {
        "\(line) \(direction) \(departure) \(destination) \(time)"
    }
    
    enum CodingKeys: String, CodingKey {
        case line_ = "line"
        case direction_ = "direction"
        case departure_ = "departure"
        case destination_ = "destination"
        case time_ = "time"
    }
}
