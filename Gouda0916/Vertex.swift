//
//  Vertex.swift
//  Gouda0916
//
//  Created by Michael Young on 11/28/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

public class Vertex {
    var key: String?
    var neighbors: [Edge]
    
    init() {
        self.neighbors = [Edge]()
    }
}
