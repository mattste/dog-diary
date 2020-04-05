//
//  AppView.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/19/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        TabView {
            EventList().tabItem {
                    Image("dog-house-icon-systemGray")
                    Text("First")
                }
            DogList()
                .tabItem {
                Image("dog-standing-icon-systemGray")
                    Text("Dogs")
                }
        }
        .font(.headline)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView().environmentObject(Store(initialState: StoreState(dogs: [createDog(name: "Winston")])))
    }
}
