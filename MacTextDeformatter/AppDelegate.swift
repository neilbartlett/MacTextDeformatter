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
        let contentView = ContentView()

        // Create the popover
        let popover = NSPopover()
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
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                self.popover.contentViewController?.view.window?.makeKey()
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
            }
        }
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

