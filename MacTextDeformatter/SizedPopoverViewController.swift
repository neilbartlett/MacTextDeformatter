//
//  SizedPopoverViewController.swift
//  MacTextDeformatter
//
//  Created by Neil Bartlett on 2025-05-04.
//  Copyright © 2025 Neil Bartlett. All rights reserved.
//


import Cocoa
import SwiftUI

class SizedPopoverViewController: NSViewController {
    init<Content: View>(rootView: Content, size: NSSize) {
        super.init(nibName: nil, bundle: nil)
        let hosting = NSHostingView(rootView: rootView)
        hosting.translatesAutoresizingMaskIntoConstraints = false
        self.view = hosting

        NSLayoutConstraint.activate([
            hosting.widthAnchor.constraint(equalToConstant: size.width),
            hosting.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}