//
//  SwiftGraph.swift
//  Gouda0916
//
//  Created by Michael Young on 11/28/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

public class SwiftGraph {
    
    private var canvas: [Vertex]
    public var isDirected: Bool
    
    
    init() {
        canvas = [Vertex]()
        isDirected = true
    }
    
    
    func addVertex(key: String) -> Vertex {
        let childVertex = Vertex()
        childVertex.key = key
        canvas.append(childVertex)
        return childVertex
    }
    
    
    func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        let newEdge = Edge()
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        if isDirected == false {
            let reversedEdge = Edge()
            reversedEdge.neighbor = source
            reversedEdge.weight = weight
            neighbor.neighbors.append(reversedEdge)
        }
    }
}
