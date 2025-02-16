//
//  File.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 10/02/24.
//

import Foundation

public struct UserProgram {
    public let uid, name, color: String
    public let points: Int
    public let company: Company?
    public let levels: [Levels]
    public let badges: [Any] = []
    public let rating: Double
    public let pointsSystem, levelsSystem, ratingSystem: Bool
    public let services: [Any]
    public let savedMoney, progressed, goal, achieved: Double
    public let repsolPinStatus: String
    public let segments: [Segment]
    public var coins: Int {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("UPDATECOINS"), object: nil, userInfo: ["coins":coins.description])
        }
    }
    public var externClientNumber: String?
    
    public init(uid: String, name: String, color: String, points: Int, company: Company?, levels: [Levels], rating: Double, pointsSystem: Bool, levelsSystem: Bool, ratingSystem: Bool, services: [Any], savedMoney: Double, progressed: Double, goal: Double, achieved: Double, repsolPinStatus: String, segments: [Segment], coins: Int, externClientNumber: String?) {
        self.color = color
        self.points = points
        self.company = company
        self.levels = levels
        self.rating = rating
        self.pointsSystem = pointsSystem
        self.levelsSystem = levelsSystem
        self.ratingSystem = ratingSystem
        self.services = services
        self.savedMoney = savedMoney
        self.progressed = progressed
        self.goal = goal
        self.achieved = achieved
        self.repsolPinStatus = repsolPinStatus
        self.segments = segments
        self.coins = coins
        self.externClientNumber = externClientNumber
        self.uid = uid
        self.name = name
    }
}
// MARK: - Level
public struct Levels {
    public let uid, title: String
    public let points: Int
    public let color: String
    public let image: String
    public let levelDescription: String
    public let isActive: Bool
    public let maxPoints: Int?
    
    public init(uid: String, title: String, points: Int, color: String, image: String, levelDescription: String, isActive: Bool, maxPoints: Int?) {
        self.uid = uid
        self.title = title
        self.points = points
        self.color = color
        self.image = image
        self.levelDescription = levelDescription
        self.isActive = isActive
        self.maxPoints = maxPoints
    }
}

