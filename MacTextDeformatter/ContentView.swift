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

//struct ContentView: View {
//    
//    // This is very wrong but need to close the popup from here
//    // probably should use a @state somehow to do this?
//    var app: AppDelegate
//    
//    var body: some View {
//        VStack {
//            Button("Deformat") {
//                // print("Deformat")
//                guard let availableType = NSPasteboard.general.availableType(from: [.rtf, .string]) else {
//                    return
//                }
//            
//                switch availableType {
//
//                case .rtf:
//                    // print("Rich Text Data")
//                    if let data = NSPasteboard.general.string(forType: .string) {
//                        NSPasteboard.general.clearContents()
//                        NSPasteboard.general.setString(data , forType: NSPasteboard.PasteboardType.string)
//                    }
//                
//                case .string:
//                    // print("Simple Text")
//                    if let data = NSPasteboard.general.string(forType: .string) {
//                        NSPasteboard.general.clearContents()
//                        NSPasteboard.general.setString(data , forType: NSPasteboard.PasteboardType.string)
//                    }
//
//                default: break
//                }
//            
//                self.app.togglePopover(self.app)
//            }
//            .buttonStyle(.bordered)
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//            Button("CSV to TSV") {
//                ClipboardTransformer.convertCSVToTSV()
//                self.app.togglePopover(self.app)
//            }
//            .buttonStyle(.bordered)
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//            Button("JSON to TSV") {
//                JSONToTSVConverter.convertClipboard(transpose: false)
//                self.app.togglePopover(self.app)
//            }
//            .buttonStyle(.bordered)
//            .frame(maxWidth: .infinity, alignment: .leading)
//
//            Button("JSON to TSV (Transposed)") {
//                JSONToTSVConverter.convertClipboard(transpose: true)
//                self.app.togglePopover(self.app)
//            }
//            .buttonStyle(.bordered)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            
//            Button("✕", action: {
//                // print("Quit")
//                NSApplication.shared.terminate(self)
//            })
//        }
//    }
//}
//
////struct ContentView_Previews: PreviewProvider {
////    static var previews: some View {
////        ContentView()
////    }
////}


struct ContentView: View {
    let app: AppDelegate

    struct Action: Identifiable {
        let id = UUID()
        let title: String
        let handler: () -> Void
    }

    var actions: [Action] {
        [
            Action(title: "Deformat Clipboard") {
                ClipboardFormatter.deformatClipboard()
                self.app.togglePopover(self.app)
            },
            Action(title: "Convert CSV to TSV") {
                ClipboardTransformer.convertCSVToTSV()
                self.app.togglePopover(self.app)
            },
            Action(title: "Convert JSON to TSV") {
                JSONToTSVConverter.convertClipboard(transpose: false)
                self.app.togglePopover(self.app)
            },
            Action(title: "Convert JSON to TSV (Transposed)") {
                JSONToTSVConverter.convertClipboard(transpose: true)
                self.app.togglePopover(self.app)
            }
        ]
    }

    var body: some View {
        VStack(spacing: 0) {
            List(actions) { action in
                Button(action.title) {
                    action.handler()
                }
                .buttonStyle(.plain)
                .padding(.vertical, 4)
            }
            .frame(minWidth: 240, idealWidth: 280, maxWidth: .infinity, minHeight: 150)
            .listStyle(.inset)

            Divider()

            HStack {
                Spacer()
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .padding()
            }
        }
        .padding(8)
        .frame(maxWidth: 300, maxHeight: 250) 
    }
}
