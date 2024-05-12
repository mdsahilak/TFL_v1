//
//  Edge.swift
//  TFL_App
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation

struct Edge {
    let destination: String
    let weight: Double
    
    init(_ destination: String, _ weight: Double) {
        self.destination = destination
        self.weight = weight
    }
}
