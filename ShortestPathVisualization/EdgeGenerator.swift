//
//  EdgeGenerator.swift
//  ShortestPathVisualization
//
//  Created by whoami on 8/27/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

import Foundation

protocol EdgeGenerator {
    static func generateEdges(for vertices: [Vertice]) -> [Int:[Int]];
}

class DummyEdgeGenerator: EdgeGenerator {
    static func getIdentifiers(for vertices: [Vertice]) -> [Int] {
        var identifiers = [Int]()
        
        for vertice in vertices {
            let identifier = vertice.identifier
            identifiers.append(identifier)
        }
        
        return identifiers
    }
    
    static func generateEdges(for vertices: [Vertice]) -> [Int:[Int]] {
        let identifiers = getIdentifiers(for: vertices)
        
        var edges = [Int:[Int]]()
        
        for fromIdentifier in identifiers {
            edges[fromIdentifier] = [Int]()
            for toIdentifier in identifiers {
                if fromIdentifier == toIdentifier { continue }
                
                if edges[fromIdentifier] != nil {
                    edges[fromIdentifier]!.append(toIdentifier)
                }
            }
        }
        
        return edges
    }
}

class SmartEdgeGenerator: EdgeGenerator {
    
    static var edgeProbability = 0.2
    
    static func getIdentifiers(for vertices: [Vertice]) -> [Int] {
        var identifiers = [Int]()
        
        for vertice in vertices {
            let identifier = vertice.identifier
            identifiers.append(identifier)
        }
        
        return identifiers
    }
    
    static func generateOutcome() -> Bool {
        let maxNumber = 1000
        let outcome = Int(arc4random()) % maxNumber
        return edgeProbability * Double(maxNumber) > Double(outcome)
    }
    
    static func generateEdges(for vertices: [Vertice]) -> [Int:[Int]] {
        let identifiers = getIdentifiers(for: vertices)
        
        var edges = [Int:[Int]]()
        
        for fromIdentifier in identifiers {
            edges[fromIdentifier] = [Int]()
        }
        
        for fromIdentifier in identifiers {
            for toIdentifier in identifiers {
                if fromIdentifier == toIdentifier { continue }
                
                if edges[fromIdentifier] != nil && generateOutcome() {
                    edges[fromIdentifier]!.append(toIdentifier)
                    edges[toIdentifier]!.append(fromIdentifier)
                }
            }
        }
        
        return edges
    }
}
