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
let graph = Graph(adjacencyList: TFLDataset.stationsInformation)

//print(graph.adjacencyList)

let (distance, path) = graph.findShortestPath(from: "Marble Arch", to: "Bank")
//print(TFLData.stationsInf ormation)
