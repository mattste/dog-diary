//
//  Dog.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/19/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation

struct Dog: Hashable, Identifiable, Codable  {
    var id: UUID
    var name: String
    var createdAt: Date
}
