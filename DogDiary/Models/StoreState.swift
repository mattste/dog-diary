//
//  StoreState.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/21/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation


struct StoreState: Codable {
    let version: String = "1.0"
    var dogs: [Dog] = []
    var events: [Event] = []
        
    init(dogs: [Dog] = [], events: [Event] = []) {
        self.dogs = dogs
        self.events = events
    }
}
