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
        // weirdness >>
        // This seems to be necessary to force a size (it is corrected later by the contentView)
        // without it the location is off
        popover.contentSize = NSSize(width: 200, height: 50)
        //<< weirdness
        popover.behavior = .transient
//        popover.contentViewController = NSHostingController(rootView: contentView)
        popover.contentViewController = SizedPopoverViewController(
            rootView: contentView,
            size: NSSize(width: 300, height: 240)
        )
        
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
        // print("Toggling Popover")
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                // print("unshowing")
                // this section is a bit of a kludge:
                // this first line ensures the pop-up is dismissed when the mouse is clicked outside the popup
                self.popover.contentViewController?.view.window?.makeKey()
                // this second line closes the the pop up if we ask it to be done - eg via button inside the
                // popup
                self.popover.performClose(sender)
            } else {
                // print("showing")
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
            }
        }
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

