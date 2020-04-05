//
//  Dogs.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/19/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation

func createDog(name: String) -> Dog {
    return Dog(id: UUID(), name: name, createdAt: Date())
}

func insertDog(store: Store, dog: Dog) -> Dog {
    store.state.dogs.append(dog)
    return dog
}

func removeDogs(store: Store, dogs: [Dog]) -> Void {
    let ids = dogs.map({ $0.id })
    store.state.dogs = store.state.dogs.filter({ dog in ids.contains(dog.id)})
}

func removeDog(store: Store, dog: Dog) -> Dog {
    store.state.dogs = store.state.dogs.filter({ d in d.id == dog.id})
    return dog
}

func findDogById(store: Store, id: Dog.ID) -> Dog? {
    store.state.dogs.first(where: { d in d.id == id })
}

func sortDogsById(_ dogs: [Dog]) -> [Dog] {
    dogs.sorted(by: {$0.id.uuidString < $1.id.uuidString })
}

func sortDogsByNameAsc(_ dogs: [Dog]) -> [Dog] {
    dogs.sorted(by: {$0.name < $1.name})
}

