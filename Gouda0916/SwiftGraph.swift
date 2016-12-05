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
    
    // Creates a new Vertex
    func addVertex(key: String) -> Vertex {
        
        // Sets the Key
        let childVertex = Vertex()
        childVertex.key = key
        
        // Adds Vertext to graph canvas
        canvas.append(childVertex)
        
        return childVertex
    }
    
    // Adds an edge to Vertex
    func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        
        // Create a new edge object
        let newEdge = Edge()
        
        // Default properties
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        // Account for undirected or directed path
        if isDirected == false {
            
            // Create a new reversed edge
            let reversedEdge = Edge()
            
            // Reversed Default properties
            reversedEdge.neighbor = source
            reversedEdge.weight = weight
            neighbor.neighbors.append(reversedEdge)
        }
    }
    
}
