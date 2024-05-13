// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct TFL_v1 {
    static func main() {
        print("Welcome to the TFL v1 Application")
        
        TFLNetwork.fetchInformation()
        
    homeLoop: while true {
        showHomeMenu()
        
        guard let input = readLine(), let option = Int(input) else {
            print("Invalid Input")
            break
        }
        
        switch option {
        case 1:
            showEngineerMenu()
            
        case 2:
            showCustomerMenu()
            
        case 3:
            print("Thank you for your time.")
            break homeLoop
            
        default:
            print("Please choose a valid option.")
        }
    }
        
    }
    
    // MARK: Common Features
    static func showHomeMenu() {
        print("Please choose a role to proceed:")
        print("1: TFL Engineer")
        print("2: Customer")
        print("3: Exit")
    }
    
    // MARK: Engineer Features
    static func showEngineerMenu() {
        
    }
    
    
    // MARK: Customer Features
    static func showCustomerMenu() {
    customerLoop: while true {
            print("Please choose an option:")
            print("1: Find a route between two stations")
            print("2: Show information about a station")
            print("3: Go Back")
            
            guard let input = readLine(), let option = Int(input) else {
                print("Invalid Input")
                return
            }
            
            switch option {
            case 1:
                findRouteBetweenStations()
                
            case 2:
                showInformationAboutStation()
                
            case 3:
                break customerLoop
                
            default:
                print("Please choose a valid option.")
            }
        }
    }
    
    static func findRouteBetweenStations() {
        print("Please enter starting station: ")
        let station1 = readLine() ?? ""
        
        print("Please enter destination station: ")
        let station2 = readLine() ?? ""
        
        let graph = Graph(adjacencyList: TFLNetwork.tubeMap)
        
        if let path = graph.findShortestPath(from: station1, to: station2) {
            TFLNetwork.showTravelJourney(for: path)
        } else {
            print("Error: Could not find a path between the given stations!")
        }
    }
    
    static func showInformationAboutStation() {
        print("Please enter the station name: ")
        let station = readLine() ?? ""
        
        TFLNetwork.showInformation(for: station)
    }
    
}
