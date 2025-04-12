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
                Text("By Evan Matthew")
                    .foregroundColor(.white)
                Image("tg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            .font(.system(size: 10))
            
            Link(destination: URL(string: "https://github.com/IvanKoskov")!) {
                Image("git")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            .font(.system(size: 10))
            
            Button(action: {
                showAboutPanel()
            }) {
                Image("generalimage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.borderless)
            .keyboardShortcut("i")
        }
    }
    
    private func showAboutPanel() {
        if aboutWindowController == nil {
            // Create the window only if it doesn’t exist
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable, .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = "SysMonitor utility"
            window.contentView = NSHostingView(rootView: AboutView())
            aboutWindowController = NSWindowController(window: window)
        }
        
        // Show the existing window (or the newly created one)
        aboutWindowController?.showWindow(nil)
        aboutWindowController?.window?.makeKeyAndOrderFront(nil) // Bring it to the front
    }
}
