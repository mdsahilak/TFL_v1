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
    
    static let url = URL(string: "https://raw.githubusercontent.com/mdsahilak/TFL_Data/main/tfl_data.json")!
    
    static func loadData() {
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
