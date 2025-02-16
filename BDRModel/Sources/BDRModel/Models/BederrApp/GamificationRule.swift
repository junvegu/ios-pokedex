//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation
// MARK: - GamificationRule
public struct GamificationRule {
    public init(uid: String, rule: String, reward: Int, typeReward: String, ruleName: String) {
        self.uid = uid
        self.rule = rule
        self.reward = reward
        self.typeReward = typeReward
        self.ruleName = ruleName
    }
    
    public let uid, rule: String
    public let reward: Int
    public let typeReward, ruleName: String
}
