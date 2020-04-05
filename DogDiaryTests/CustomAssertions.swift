//
//  CustomAssertions.swift
//  DogDiaryTests
//
//  Created by Matthew Stewart-Ronnisch on 2/20/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import XCTest

func AssertArrayContainsItem<T: Equatable>(arr: [T], item: T, file: StaticString = #file, line: UInt = #line) {
    if !arr.contains(item) {
        XCTFail("Array \(arr) does not contain item \(item)")
    }
}
