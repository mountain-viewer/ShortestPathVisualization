//
//  PathSolver.swift
//  ShortestPathVisualization
//
//  Created by whoami on 8/27/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

import Foundation

protocol PathSolver {
    static func findShortestPath(for graph: Graph,
                          start startIdentifier: Int,
                          finish finishIdentifier: Int) -> [Double:[Int]]?
}

class DijkstraPathSolver: PathSolver {
    
    static func findShortestPath(for graph: Graph,
                          start startIdentifier: Int,
                          finish finishIdentifier: Int) -> [Double:[Int]]? {
        let identifiers = graph.getIdentifiers()
        var visitedIdentifiers = Set<Int>()
        
        var distances = [Int:Double]()
        var previous = [Int:Int]()
        for identifier in identifiers {
            distances[identifier] = Double(MAXFLOAT)
            previous[identifier] = -1
        }
        
        distances[startIdentifier] = 0.0
        
        while true {
            var bestIdentifier = -1
            var bestDistance = Double(MAXFLOAT)
            
            for identifier in identifiers {
                guard let distance = distances[identifier] else { continue }
                if !visitedIdentifiers.contains(identifier) && distance < bestDistance {
                    bestDistance = distance
                    bestIdentifier = identifier
                }
            }
            
            if bestIdentifier == -1 {
                break
            }
            
            visitedIdentifiers.insert(bestIdentifier)
            
            guard let adjacentIdentifiers = graph.edges[bestIdentifier] else { continue }
            
            for adjacentIdentifier in adjacentIdentifiers {

                guard let oneStepDistance = graph.getDistance(from: bestIdentifier, to: adjacentIdentifier),
                    let distanceToBestIdentifier = distances[bestIdentifier],
                    let distanceToAdjacentIdentifier = distances[adjacentIdentifier] else { continue }
                
                if !visitedIdentifiers.contains(adjacentIdentifier) && distanceToBestIdentifier + oneStepDistance < distanceToAdjacentIdentifier {
                    distances[adjacentIdentifier] = distanceToBestIdentifier + oneStepDistance
                    previous[adjacentIdentifier] = bestIdentifier
                }
            }
        }
    
        guard let distanceToFinishIdentifier = distances[finishIdentifier] else { return nil }
        
        if distanceToFinishIdentifier > Double(MAXFLOAT) - 1.0 {
            return nil
        }
        
        var path = [Int]()
        var currentIdentifier = finishIdentifier
        
        while currentIdentifier != -1 {
            path.append(currentIdentifier)
            guard let previousIdentifier = previous[currentIdentifier] else { return nil }
            currentIdentifier = previousIdentifier
        }
        
        path.reverse()
        
        return [distanceToFinishIdentifier:path]
    }
}
