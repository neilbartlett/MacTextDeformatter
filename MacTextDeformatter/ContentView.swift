//
//  ContentView.swift
//  MacTextDeformatter
//
//  Created by Neil Bartlett on 2020-06-07.
//  Copyright © 2020 Neil Bartlett. All rights reserved.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack {
        Button("Deformat", action:{ print("Deformat") })
        Button("Quit", action: {print("Quit") })
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
