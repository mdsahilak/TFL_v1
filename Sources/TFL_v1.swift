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
            continue
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
    engineerLoop: while true {
            print("Please choose an option:")
            print("1: Add track section delay")
            print("2: Remove track section delay")
            print("3: Close track section")
            print("4: Open track section")
            print("5: Show track section delays")
            print("6: Show closed track sections")
            print("7: Go Back")
            
            guard let input = readLine(), let option = Int(input) else {
                print("Invalid Input")
                continue
            }
            
            switch option {
            case 1:
                addTrackSectionDelay()
                
            case 2:
                removeTrackSectionDelay()
                
            case 3:
                closeTrackSection()
                
            case 4:
                openTrackSection()
                
            case 5:
                showTrackSectionDelays()
                
            case 6:
                showClosedTrackSections()
                
            case 7:
                print("<-")
                break engineerLoop
                
            default:
                print("Please choose a valid option.")
            }
        }
    }
    
    static func addTrackSectionDelay() {
        if let section = collectTrackSectionInformation(withDelay: true) {
            TFLNetwork.addDelay(section)
        } else {
            print("ERROR: Invalid Input")
        }
    }
    
    static func removeTrackSectionDelay() {
        if let section = collectTrackSectionInformation(withDelay: false) {
            TFLNetwork.removeDelay(section)
        } else {
            print("ERROR: Invalid Input")
        }
    }
    
    static func closeTrackSection() {
        
    }
    
    static func openTrackSection() {
        
    }
    
    static func showTrackSectionDelays() {
        TFLNetwork.showDelayedSections()
    }
    
    static func showClosedTrackSections() {
        TFLNetwork.showClosedSections()
    }
    
    static func collectTrackSectionInformation(withDelay: Bool = false) -> TrackSectionInfo? {
        print("Please enter the following details for your preferred track section")
        
        print("Start Station: ")
        let start = readLine() ?? ""
        
        print("End Station: ")
        let end = readLine() ?? ""
        
        print("Line: ")
        let line = readLine() ?? ""
        
        print("Direction: ")
        let direction = readLine() ?? ""
        
        if withDelay {
            print("Delay: ")
            guard let input = readLine(), let delay = Double(input) else { return nil }
            return TrackSectionInfo(start: start, end: end, line: line, direction: direction, delay: delay)
        } else {
            return TrackSectionInfo(start: start, end: end, line: line, direction: direction)
        }
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
                continue
            }
            
            switch option {
            case 1:
                findRouteBetweenStations()
                
            case 2:
                showInformationAboutStation()
                
            case 3:
                print("<-")
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

struct TrackSectionInfo: CustomStringConvertible, Equatable {
    var start: String
    var end: String
    
    var line: String
    var direction: String
    
    var delay: Double
    
    init(start: String, end: String, line: String, direction: String, delay: Double = 0.0) {
        self.start = start
        self.end = end
        self.line = line
        self.direction = direction
        self.delay = delay
    }
    
    init(station: String, edge: Edge, delay: Double = 0.0) {
        self.start = station
        self.end = edge.destination
        
        self.line = edge.line
        self.direction = edge.direction
        
        self.delay = delay
    }
    
    var description: String {
        "\(line.capitalized.trimmingCharacters(in: .whitespacesAndNewlines)) (\(direction)) : \(start) to \(end) - \(delay) min delay"
    }
}
