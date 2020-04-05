//
//  DogList.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/20/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import SwiftUI

struct DogList: View {
    @EnvironmentObject var store: Store
    @State var editMode: EditMode = EditMode.inactive
    @State var showAddDogSheet = false
    @State var newDogData = NewDogData()
    
    var editButton: some View {
        Button(action: { self.editMode.toggle() }) {
            Text(self.editMode.title)
        }
    }
    
    
    var addButton: some View {
        Button(action: { self.showAddDogSheet.toggle() }) {
            Image(systemName: "plus").imageScale(.large)
        }.sheet(isPresented: $showAddDogSheet) {
            self.addDogProfileSheet
        }
    }
    
    var addDogProfileSheet: some View {
        NavigationView {
            AddDogProfile(data: $newDogData)
            .navigationBarTitle("New Dog", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.showAddDogSheet = false
            }) {
                Text("Cancel").bold()
                }, trailing: Button(action: {
                    let _ = insertDog(store: self.store, dog: createDog(name: self.newDogData.name))
                    self.newDogData = NewDogData()
                    self.showAddDogSheet = false
                }) {
                    Text("Save").bold()
            })
        }
    }
        
    var body: some View {
        let dogs =  (store.state.dogs)
        return NavigationView {
            List {
                ForEach(dogs) { dog in
                    Text(dog.name)
                }.onDelete(perform: { offsets in self._removeDogs(dogs: dogs, at: offsets) })
            }
            .environment(\.editMode, self.$editMode)
            .navigationBarTitle(Text("Your Dogs"))
            .navigationBarItems(leading: self.editButton, trailing: self.addButton)
            
        }
    }
    
    func _removeDogs(dogs: [Dog], at offsets: IndexSet) {
        let dogsToRemove = offsets.map({dogs[$0]})
        removeDogs(store: store, dogs: dogsToRemove)
    }
}

struct DogList_Previews: PreviewProvider {
    static var previews: some View {
        let state = StoreState(dogs:
            [createDog(name: "Winston"), createDog(name: "Coconut")])
        return DogList().environmentObject(Store(initialState: state))
    }
}
