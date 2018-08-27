//
//  ViewController.swift
//  ShortestPathVisualization
//
//  Created by whoami on 8/26/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var graph: Graph!
    
    @IBOutlet weak var gridView: UIView!
    
    @IBAction func update(_ sender: UIButton) {
        clear()
        SmartEdgeGenerator.edgeProbability = 0.01
        graph = Graph(with: 100, with: self.gridView.bounds)
        updateViewFromModel()
    }
    
    func clear() {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.gridView.bounds.size.height))
        path.addLine(to: CGPoint(x: self.gridView.bounds.size.width, y: self.gridView.bounds.size.height))
        path.addLine(to: CGPoint(x: self.gridView.bounds.size.width, y: 0.0))
        path.close()
        
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        gridView.layer.addSublayer(layer)
    }
    
    func updateViewFromModel() {
        updateVertices()
        updateEdges()
        updatePath()
    }
    
    func updateVertices() {
        let vertices = graph.vertices
        
        for vertice in vertices {
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: vertice.x, y: vertice.y),
                                          radius: CGFloat(vertice.radius),
                                          startAngle: CGFloat(0),
                                          endAngle:CGFloat(Double.pi * 2),
                                          clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.lineWidth = 1.0
            
            gridView.layer.addSublayer(shapeLayer)
        }
    }
    
    func updateEdges() {
        let identifiers = graph.getIdentifiers()
        
        for identifier in identifiers {
            guard let adjacentVerticeIdentifiers = graph.edges[identifier] else { continue }
            for adjacentIdentifier in adjacentVerticeIdentifiers {
                if identifier == adjacentIdentifier { continue }
                
                guard let fromVertice = graph.getVertice(with: identifier),
                    let toVertice = graph.getVertice(with: adjacentIdentifier) else { continue }
                
                updateEdge(from: fromVertice, to: toVertice)
            }
        }
    }
    
    func updateEdge(from fromVertice: Vertice, to toVertice: Vertice) {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: fromVertice.x, y: fromVertice.y))
        path.addLine(to: CGPoint(x: toVertice.x, y: toVertice.y))
   
        layer.path = path.cgPath
        layer.strokeColor = UIColor.lightGray.cgColor
        gridView.layer.addSublayer(layer)
    }
    
    func updatePath() {
        let identifiers = graph.getIdentifiers()
        
        guard let startIdentifier = identifiers.first else { return }
        guard let finishIdentifier = identifiers.last else { return }
        
        guard let pathResult = DijkstraPathSolver.findShortestPath(for: graph, start: startIdentifier, finish: finishIdentifier) else { return }
        guard let distance = pathResult.keys.first else { return }
        guard let path = pathResult[distance] else { return }

        
        for index in 0..<path.count - 1 {
            let layer = CAShapeLayer()
            
            guard let fromVertice = graph.getVertice(with: path[index]) else { return }
            guard let toVertice = graph.getVertice(with: path[index + 1]) else { return }
            let arrow = UIBezierPath.arrow(from: CGPoint(x: fromVertice.x, y: fromVertice.y),
                                           to: CGPoint(x: toVertice.x, y: toVertice.y),
                                           tailWidth: 1, headWidth: 5, headLength: 8)
            layer.path = arrow.cgPath
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = UIColor.black.cgColor
            gridView.layer.addSublayer(layer)
        }
    }
    
}

