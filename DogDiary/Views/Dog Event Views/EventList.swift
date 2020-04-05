//
//  EventList.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/21/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import SwiftUI

struct EventList: View {
    @EnvironmentObject var store: Store
    @State var editMode: EditMode = EditMode.inactive
    @State var showAddEvent = false
    
    var editButton: some View {
        Button(action: { self.editMode.toggle() }) {
            Text(self.editMode.title).bold()
        }
    }
    
    var addButton: some View {
        Button(action: { self.showAddEvent = true }) {
            Text("Add").bold()
        }.sheet(isPresented: $showAddEvent) {
            AddEvent(dogs: self.store.state.dogs, onCreate: self._insertEvents, onDismiss: { self.showAddEvent = false})
        }
    }
    
    func makeEventRow(event: Event) -> some View {
        let dog = findDogById(store: self.store, id: event.dogId)
        return Unwrap(dog) { dog in
            EventRow(event: event, dog: dog)
        }
    }
    

    
    var body: some View {
        let events = sortEventsByDateDesc(events: store.state.events)
        return NavigationView {
            List {
                ForEach(events, id: \.id) { event in
                    self.makeEventRow(event: event)
                }.onDelete(perform: {self._removeEvents(events: events, at: $0) })
            }
            .environment(\.editMode, self.$editMode)
            .navigationBarTitle(Text("Your Events"))
            .navigationBarItems(leading: self.editButton, trailing: self.addButton)
        }
    }
    
    func _insertEvents(events: [Event]) -> Void {
        let _ = insertEvents(store: self.store, events: events)
        self.showAddEvent = false
    }
    
    func _removeEvents(events: [Event], at offsets: IndexSet) -> Void {
        let eventsToRemove = offsets.map({events[$0]})
        removeEvents(store: store, events: eventsToRemove)
    }

}

struct EventRow: View {
    var event: Event
    var dog: Dog
    
    private func actionView(action: EventAction) -> some View {
        switch(action) {
            case .poop: return Text("Poop")
            case .pee: return Text("Pee")
        }
    }
    
    var eventActions: some View {
        let actions = Array(event.actions.sorted())
        return HStack {
            ForEach(actions, id: \.self, content: self.actionView)
        }
    }
    
    var body: some View {
        HStack {
            self.eventActions
            Text(dog.name)
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        let dog1 = createDog(name: "Winston")
        let dog2 = createDog(name: "Coconut")
        let events = [createEvent(dogId: dog1.id, actions: [.pee]), createEvent(dogId: dog2.id, actions: [.poop, .pee])]
        let state = StoreState(dogs: [dog1, dog2], events: events)
        return EventList().environmentObject(Store(initialState: state))
    }
}
