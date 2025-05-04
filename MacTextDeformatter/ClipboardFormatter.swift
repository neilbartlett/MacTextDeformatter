//
//  ClipboardFormatter.swift
//  MacTextDeformatter
//
//  Created by Neil Bartlett on 2025-05-04.
//  Copyright © 2025 Neil Bartlett. All rights reserved.
//

import Foundation
import SwiftUI
import Cocoa

enum ClipboardFormatter {
    static func deformatClipboard() {
            // print("Deformat")
            guard let availableType = NSPasteboard.general.availableType(from: [.rtf, .string]) else {
                return
            }

            switch availableType {

            case .rtf:
                // print("Rich Text Data")
                if let data = NSPasteboard.general.string(forType: .string) {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(data , forType: NSPasteboard.PasteboardType.string)
                }

            case .string:
                // print("Simple Text")
                if let data = NSPasteboard.general.string(forType: .string) {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(data , forType: NSPasteboard.PasteboardType.string)
                }

            default: break
            }
        
    }
}
