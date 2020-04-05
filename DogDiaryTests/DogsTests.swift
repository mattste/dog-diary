//
//  DogsTests.swift
//  DogDiaryTests
//
//  Created by Matthew Stewart-Ronnisch on 2/20/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import XCTest

@testable import DogDiary

class DogsTest: XCTestCase {

    private var store: Store!
    
    override func setUp() {
        super.setUp()
        store = Store.init()
    }

    func testInsertDog() {
        XCTAssertEqual(store.state.dogs, [])
        let dog = createDog(name: "Winston")
        let _ = insertDog(store: store, dog: dog)
        AssertArrayContainsItem(arr: store.state.dogs, item: dog)
    }

}
