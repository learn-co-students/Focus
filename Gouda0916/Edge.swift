//
//  Edge.swift
//  Gouda0916
//
//  Created by Michael Young on 11/28/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

public class Edge {
    
    var neighbor: Vertex
    var weight: Int
    
    
    init() {
        weight = 0
        self.neighbor = Vertex()
    }
}
