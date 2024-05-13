// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct TFL_v1 {
    static func main() {
        print("Welcome to the TFL v1 Application")

        TFLDataset.fetchInformation()
        
        while true {
            showHomeMenu()
            
            guard let input = readLine(), let option = Int(input) else {
                print("Invalid Input")
                exit(0)
            }
            
            switch option {
            case 1:
                findRouteBetweenStations()
                
            case 2:
                showInformationAboutStation()
                
            case 3:
                exitApp()
                
            default:
                print("Please choose a valid option.")
                exit(0)
            }
        }

    }
    
    // MARK: Common Features
    static func showHomeMenu() {
        print("Please choose an option:")
        print("1: Find a route between two stations")
        print("2: Show information about a station")
        print("3: Exit")
    }
    
    static func exitApp() {
        print("Thank you for your time.")
        exit(0)
    }
    
    // MARK: Manager Features
    
    
    // MARK: Customer Features
    static func findRouteBetweenStations() {
        print("Please enter starting station: ")
        let station1 = readLine() ?? ""
        
        print("Please enter destination station: ")
        let station2 = readLine() ?? ""
        
        let graph = Graph(adjacencyList: TFLDataset.tubeNetwork)
        
        if let path = graph.findShortestPath(from: station1, to: station2) {
            TFLDataset.showTravelJourney(for: path)
        } else {
            displayPathFindError()
            exit(0)
        }
    }
    
    static func showInformationAboutStation() {
        print("Please enter the station name: ")
        let station = readLine() ?? ""
        
        TFLDataset.showInformation(for: station)
    }
    
    // MARK: Helpers
    static func displayPathFindError() {
        print("Error: Could not find a path between the given stations!")
    }
    
    static func showcasePathFindingAlgorithm() {
        let graph = Graph(adjacencyList: TFLDataset.tubeNetwork)
        let path = graph.findShortestPath(from: "Marble Arch", to: "Great Portland Street")
        
        if let path {
            TFLDataset.showTravelJourney(for: path)
        } else {
            displayPathFindError()
            exit(0)
        }
    }
}
