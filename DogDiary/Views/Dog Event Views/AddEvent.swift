//
//  AddEvent.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/23/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import SwiftUI

typealias DogActionsState = [Dog.ID: Set<EventAction>]

struct AddEvent: View {
    var dogs: [Dog]
    var onCreate: (_ events: [Event]) -> ()
    var onDismiss: () -> ()
    
    @State private var actions: DogActionsState = DogActionsState()
    
    var cancelButton: some View {
        Button(action: { self.onDismiss() }) {
            Text("Cancel").bold()
        }
    }
    
    var saveButton: some View {
        Button(action: {
            self.onCreate(self._createEvents())
        }) {
            Text("Save").bold()
        }
    }
    
    var body: some View {
        NavigationView {
            ForEach(dogs) { dog in
                Text(dog.name).bold()
                Text("poop").onTapGesture {
                    self.toggleAction(dogId: dog.id, action: .poop)
                }
                Text("pee").onTapGesture {
                    self.toggleAction(dogId: dog.id, action: .pee)
                }
            }
            .navigationBarTitle(Text("New Event"), displayMode: .inline)
            .navigationBarItems(leading: self.cancelButton, trailing: self.saveButton)
        }
    }
    
    func toggleAction(dogId: Dog.ID, action: EventAction) -> Void {
        var dogActions = self.actions[dogId] ?? []
        let _ = dogActions.insertOrRemove(item: action)
        self.actions[dogId] = dogActions
    }
    
    func _createEvents() -> [Event] {
        self.dogs.map({
            createEvent(dogId: $0.id, actions: self.actions[$0.id] ?? [])
        }).filter({
            // only create events for dogs that had an action selected for them
            $0.actions.isEmpty == false
        })
    }
}

struct AddEvent_Previews: PreviewProvider {
    static var previews: some View {
        let dogs: [Dog] = [createDog(name: "Winston"), createDog(name: "Coconut")]
        return AddEvent(dogs: dogs, onCreate: {_ in }, onDismiss: {} )
    }
}
