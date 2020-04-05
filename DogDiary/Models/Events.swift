//
//  Events.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/29/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import Foundation

func createEvent(dogId: Dog.ID, actions: EventActions) -> Event {
    return Event(id: UUID(), dogId: dogId, actions: actions, createdAt: Date())
}

func insertEvents(store: Store, events: [Event]) -> [Event] {
    store.state.events.append(contentsOf: events)
    return events
}

func removeEvents(store: Store, events: [Event]) -> Void {
    let ids = events.map({ $0.id })
    store.state.events = store.state.events.filter({ event in ids.contains(event.id)})
}

func sortEventsByDateDesc(events: [Event]) -> [Event] {
    return events.sorted(by: {$0.createdAt > $1.createdAt})
}
