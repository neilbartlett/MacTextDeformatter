//
//  ContentView.swift
//  MacTextDeformatter
//
//  Created by Neil Bartlett on 2020-06-07.
//  Copyright © 2020 Neil Bartlett. All rights reserved.
//
// TODOS
// -- putting code in the content view seems wrong. Ideally should seaparate view description from code
//

import SwiftUI
import Cocoa

struct ContentView: View {
    
  var body: some View {
    HStack {
        Button("Deformat", action:{
            print("Deformat")
            guard let availableType = NSPasteboard.general.availableType(from: [.rtf, .string]) else {
                return
            }
            
            switch availableType {

            case .rtf:
                print("Rich Text Data")
                if let data = NSPasteboard.general.string(forType: .string) {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(data , forType: NSPasteboard.PasteboardType.string)
                }
                
            case .string:
                print("Simple Text")
                if let data = NSPasteboard.general.string(forType: .string) {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(data , forType: NSPasteboard.PasteboardType.string)
                }

            default: break
            }
            
        })

        Button("✕", action: {
            print("Quit")
            NSApplication.shared.terminate(self)
        })
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
