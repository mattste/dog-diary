//
//  Event.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/23/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation

struct Event: Hashable, Identifiable, Codable  {
    var id: UUID
    var dogId: UUID
    var actions: EventActions
    var createdAt: Date
}

typealias EventActions = Set<EventAction>

enum EventAction: String, Codable, Comparable {
    case poop = "poop"
    case pee = "pee"
    
    static func < (lhs: EventAction, rhs: EventAction) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
