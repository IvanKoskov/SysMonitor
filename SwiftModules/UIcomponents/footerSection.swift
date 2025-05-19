//
//  footerSection.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

import SwiftUI

struct footerSection: View {
    @State private var aboutWindowController: NSWindowController? // Store the window controller

    var body: some View {
        HStack {
            Link(destination: URL(string: "https://t.me/Evan_Matthew")!) {
                Text("♡ By Evan Matthew")
                    .foregroundColor(.white)
            }
            .offset(y: 15)
            .font(.system(size: 10))
            
    
            
        }
    }
    
    private func showAboutPanel() {
        if aboutWindowController == nil {
            // Create the window only if it doesn’t exist
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable, .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = "SysMonitor utility"
            window.level = .floating
            window.contentView = NSHostingView(rootView: AboutView())
            aboutWindowController = NSWindowController(window: window)
        }
        
        // Show the existing window (or the newly created one)
        aboutWindowController?.showWindow(nil)
        aboutWindowController?.window?.makeKeyAndOrderFront(nil) // Bring it to the front
    }
}
