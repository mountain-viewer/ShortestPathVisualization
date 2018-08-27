//
//  VerticeGenerator.swift
//  ShortestPathVisualization
//
//  Created by whoami on 8/27/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

import Foundation
import CoreGraphics

struct VerticeGenerator {
    
    static var defaultRadius = 5;
    static var defaultLowerBound = 3;
    static var defaultUpperBound = 13;
    
    static func generateRadius(greater lowerBound: Int,
                               less upperBound: Int) -> Int {
        if lowerBound >= upperBound {
            return defaultRadius
        }
        
        let difference = upperBound - lowerBound
        let maxValue = (difference + 1) / 2
        let randomVariable = Int(arc4random()) % (maxValue + 1)
        
        var radius: Int
        
        if lowerBound % 2 == 0 {
            radius = lowerBound + 2 * randomVariable - 1
        } else {
            radius = lowerBound + 2 * randomVariable
        }
        
        return radius
    }
    
    static func generateVertice(for grid: CGRect) -> Vertice {
        let radius = VerticeGenerator.generateRadius(greater: defaultLowerBound,
                                                     less: defaultUpperBound)
        
        let width = Int(grid.width)
        let height = Int(grid.height)
        
        let x = Int(arc4random()) % (width - 2 * (radius + 1)) + Int(grid.origin.x) + radius + 1
        let y = Int(arc4random()) % (height - 2 * (radius + 1)) + Int(grid.origin.y) + radius + 1
        
        let identifier = Vertice.generateNextIdentifier()
        
        let vertice = Vertice(x: x, y: y, radius: radius, identifier: identifier)
        return vertice
    }
}
