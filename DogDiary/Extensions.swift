//
//  Extensions.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/21/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation
import SwiftUI

extension EditMode {
    var title: String {
        self == .active ? "Done" : "Edit"
    }

    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

enum InsertOrRemoveResult {
    case inserted
    case removed
}

extension Set {
    mutating func insertOrRemove(item: Element) -> InsertOrRemoveResult {
        if self.contains(item) {
            self.remove(item)
            return InsertOrRemoveResult.removed
        } else {
            self.insert(item)
            return InsertOrRemoveResult.inserted
        }
    }
}

extension Dictionary {
    init<T: Identifiable>(values: Array<T>) {
        let keysWithValues = values.map({(element) -> (Key, Value) in
            (element.id as! Key, element as! Value)
        })
        self.init(minimumCapacity: keysWithValues.underestimatedCount)
        for (key, value) in keysWithValues {
            self[key] = value
        }
    }
}
