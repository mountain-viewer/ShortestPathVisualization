//
//  Vertice.swift
//  ShortestPathVisualization
//
//  Created by whoami on 8/26/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

import Foundation

struct Vertice {
    
    static var currentIdentifier = 1
    
    static func generateNextIdentifier() -> Int {
        let identifier = currentIdentifier
        currentIdentifier += 1
        return identifier
    }
    
    var x: Int
    var y: Int
    var radius: Int
    var identifier: Int
}
