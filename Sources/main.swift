// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

print("Hello, world!")

//let graph = Graph(adjacencyList: [
//    "A": [Edge("B", 4), Edge("C", 9)],
//    "B": [Edge("A", 4), Edge("C", 5), Edge("D", 9)],
//    "C": [Edge("A", 9), Edge("B", 5), Edge("C", 7)],
//    "D": [Edge("C", 7), Edge("B", 9), Edge("E", 2)],
//    "E": [Edge("D", 2)]
//])
//
//let (distance, path) = graph.findShortestPath(from: "A", to: "E")

TFLDataset.loadData()

while true {
    let graph = Graph(adjacencyList: TFLDataset.stationsInformation)
    
    print("Please choose an option:")
    print("1: Find Route between two stations:")
    print("2: Exit")
    
    guard let input = readLine(), let option = Int(input) else {
        print("Invalid Input")
        exit(0)
    }
    
    switch option {
    case 1:
        print("Please enter starting station:")
        let station1 = readLine() ?? ""
        
        print("Please enter destination station:")
        let station2 = readLine() ?? ""
        
        let (_) = graph.findShortestPath(from: station1, to: station2)
    case 2:
        print("Thank you.")
        exit(0)
    default:
        print("Please choose a valid option.")
        exit(0)
    }
}
