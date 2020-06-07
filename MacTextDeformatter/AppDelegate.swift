//
//  AppDelegate.swift
//  MacTextDeformatter
//
//  Created by Neil Bartlett on 2020-06-07.
//  Copyright © 2020 Neil Bartlett. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView(app: self)
        //contentView.app = self

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 100, height: 50) // This seems to be necessary to force a size (it is correctly later by the contetnView)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        //  self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            statusBarItem.button?.title = "T"
            statusBarItem.button?.target = self
            button.action = #selector(togglePopover(_:))
        }
        
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        print("Toggling Popover")
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                print("unshowing")
                self.popover.contentViewController?.view.window?.makeKey()
                self.popover.performClose(sender)
            } else {
                print("showing")
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
            }
        }
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

