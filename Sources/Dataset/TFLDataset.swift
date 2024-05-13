//
//  TFLDataset.swift
//  TFL_App
//
//  Created by Sahil Ak on 11/05/24.
//

import Foundation

struct TFLDataset {
    static var tubeNetwork: [String: [Edge]] = [:]
    
    // Local File URL
    // static let url = URL(fileURLWithPath: "/Users/sahil/Desktop/Westminster/DSA_CW/TFL/TFL.json")!
    
    // Hosted File URL
    static let url = URL(string: "https://raw.githubusercontent.com/mdsahilak/TFL_Data/main/tfl_data.json")!
    
    static func fetchInformation() {
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let trainTimes = try decoder.decode([TrainTimeInfo].self, from: data)
            
            // Make station information
            for trainTime in trainTimes {
                let edge = Edge(trainTime.destination, trainTime.time, line: trainTime.line, direction: trainTime.direction)
                
                if let _ = tubeNetwork[trainTime.departure] {
                    tubeNetwork[trainTime.departure]!.append(edge)
                } else {
                    tubeNetwork[trainTime.departure] = [edge]
                }
            }
        } catch {
            print(error)
        }
    }
    
    static func showTravelJourney(for path: String) {
        let stations: [String] = path.components(separatedBy: "->")
        var totalTime: Double = 0.0
        
        showDividerLine()
        print("Tube Journey from \(stations.first ?? "-") to \(stations.last ?? "-")")
        showDividerLine()
        
        for i in 0..<stations.count - 1 {
            let station = stations[i]
            let nextStation = stations[i+1]
            
            let edges = tubeNetwork[station] ?? []
            let edge = edges.first(where: { $0.destination == nextStation })
            
            if let edge {
                let line = edge.line.trimmingCharacters(in: .whitespacesAndNewlines)
                totalTime += edge.weight
                
                print("\(i + 1). \(line.capitalized) (\(edge.direction.capitalized)): \(station) -> \(edge.destination) : \(edge.weight) mins")
            }
        }
        
        showDividerLine()
        print("Total Journey Time: \(totalTime) mins")
        showDividerLine()
    }
    
    static func showInformation(for station: String) {
        if let edges = tubeNetwork[station.capitalized] {
            print("Name: \(station)")
            
            let lines: Set<String> = Set(edges.map { $0.line.trimmingCharacters(in: .whitespacesAndNewlines) })
            print("Lines: \n \(lines)")
            
            print("Nearby Stations: ")
            for edge in edges {
                print(" \(edge.description)")
            }
        } else {
            print("ERROR: No Information Found!")
        }
    }
    
    static func getEdge(from a: String, to b: String) -> Edge? {
        let station = tubeNetwork[a]
        
        let edge = station?.first(where: { $0.destination == b })
        
        return edge
    }
    
    static func showDividerLine() {
        print("-----------------------------------------------------------------------")
    }
}

