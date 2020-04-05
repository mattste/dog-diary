//
//  UtilityViews.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/29/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}
