//
//  PriorityQueue.swift
//  TFL_App
//
//  Created by Sahil Ak on 12/05/24.
//

import Foundation

// Priority Queue backed by an array as storage
struct PriorityQueue<T> {
    struct QEntry {
        let element: T
        let priority: Double
    }
    
    private var entries: [QEntry] = []

    mutating func enqueue(_ element: T, priority: Double) {
        entries.append(.init(element: element, priority: priority))
        entries.sort { $0.priority < $1.priority }
    }

    mutating func dequeue() -> (element: T, priority: Double)? {
        if entries.isEmpty {
            return nil
        } else {
            let val = entries.removeFirst()
            return (val.element, val.priority)
        }
    }

    var isEmpty: Bool {
        return entries.isEmpty
    }
}
