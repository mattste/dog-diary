//
//  Repository.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/19/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation

protocol Repository {
    init(withData data: StoreState)
    func get() -> StoreState?
    func update(state: StoreState) -> Void
}


struct UserDefaultsRepository: Repository {
    
    var name: String = "store"
    
    init() {}
    
    init(name: String) {
        self.name = name
    }
    
    init(withData data: StoreState) {
        UserDefaults.standard.set(data, forKey: name)
    }
    
    func get() -> StoreState? {
        decode(data: UserDefaults.standard.data(forKey: name))
    }
    
    func update(state: StoreState) -> Void {
        UserDefaults.standard.set(encode(state: state), forKey: name)
    }
}

func encode(state: StoreState) -> Data {
    do {
       let encoder = JSONEncoder()
       return try encoder.encode(state)
   } catch {
       fatalError("Couldn't encode \(state) as Data :\n\(error)")
   }
}

func decode(data: Data?) -> StoreState? {
    do {
        guard let data = data else {
            return nil
        }

        let decoder = JSONDecoder()
        return try decoder.decode(StoreState.self, from: data)
    } catch {
        fatalError("Couldn't decode \(String(describing: data)) as \(StoreState.self):\n\(error)")
    }
}
