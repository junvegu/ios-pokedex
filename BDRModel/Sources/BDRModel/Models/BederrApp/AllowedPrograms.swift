//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation

// MARK: - AllowedProgram
public struct AllowedProgram: Decodable {
    public init(uid: String, name: String, segments: [Segment]) {
        self.uid = uid
        self.name = name
        self.segments = segments
    }
    
    public let uid, name: String
    public let segments: [Segment]
}
