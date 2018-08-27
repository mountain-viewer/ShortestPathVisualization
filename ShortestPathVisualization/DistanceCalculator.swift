//
//  DistanceCalculator.swift
//  ShortestPathVisualization
//
//  Created by whoami on 8/27/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

import Foundation
import CoreGraphics

class DistanceCalculator {
    static func calculateDistance(between fromPoint: CGPoint, and toPoint: CGPoint) -> Double {
        let deltaX = toPoint.x - fromPoint.x
        let deltaY = toPoint.y - fromPoint.y
        return Double(sqrt(deltaX * deltaX + deltaY * deltaY))
    }
}
