//
//  AddDogProfile.swift
//  DogDiary
//
//  Created by Matthew Stewart-Ronnisch on 2/20/20.
//  Copyright © 2020 Matthew Stewart-Ronnisch. All rights reserved.
//

import SwiftUI

struct NewDogData {
    var name: String = ""
}


struct AddDogProfile: View {
    @Binding var data: NewDogData
    
    var body: some View {
        TextField("Name", text: $data.name)
    }
}

struct AddDogProfile_Previews: PreviewProvider {
    static var previews: some View {
       Wrapper()
    }
    
    struct Wrapper: View {
      @State var data = NewDogData()

      var body: some View {
        AddDogProfile(data: $data)
      }
    }
}


