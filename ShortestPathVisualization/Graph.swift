//
//  Graph.swift
//  ShortestPathVisualization
//
//  Created by whoami on 8/26/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

import Foundation
import CoreGraphics

struct Graph {
    var vertices: [Vertice]
    var edges: [Int: [Int]]
    
    init(with numberOfVertices: Int, with grid: CGRect) {
        vertices = [Vertice]()
        
        for _ in 0..<numberOfVertices {
            let vertice = VerticeGenerator.generateVertice(for: grid)
            vertices.append(vertice)
        }
        
        edges = SmartEdgeGenerator.generateEdges(for: vertices)
    }
    
    func getVertice(with identifier: Int) -> Vertice? {
        for vertice in vertices {
            if vertice.identifier == identifier {
                return vertice
            }
        }
        
        return nil
    }
    
    func getIdentifiers() -> [Int] {
        var identifiers = [Int]()
        
        for vertice in vertices {
            identifiers.append(vertice.identifier)
        }
        
        return identifiers
    }
    
    func getDistance(from fromIdentifier: Int, to toIdentifier: Int) -> Double? {
        guard let fromVertice = getVertice(with: fromIdentifier),
            let toVertice = getVertice(with: toIdentifier) else { return nil }
        
        let fromPoint = CGPoint(x: fromVertice.x, y: fromVertice.y)
        let toPoint = CGPoint(x: toVertice.x, y: toVertice.y)
        
        let distance = DistanceCalculator.calculateDistance(between: fromPoint, and: toPoint)
        return distance
    }
}
