//
//  Store.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/19/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published var state: StoreState
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(initialState: StoreState = StoreState()) {
        self.state = initialState
    }
    
    init(fromRepo repo: Repository) {
        self.state = repo.get() ?? StoreState()
    }
    
    func subscribe(repo: Repository) -> Void {
        $state.sink { state in
            repo.update(state: state)
        }.store(in: &self.cancellables)
    }
}
