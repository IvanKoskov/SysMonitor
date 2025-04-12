//
//  userView.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

import SwiftUI

struct userView: View {
    
    @State private var aboutWindowController: NSWindowController?
    
    @State private var dynamicInfo = "Initial Info"
    
    @State private var userName: String = ""
    
    @Environment(\.openWindow) private var openAllUsersWindow
    
    
    var body: some View {
        

        
            HStack {
                
                Text(userName)
                   // .textSelection(.enabled)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .contextMenu{
                        
                        Button {
                         //   openAllUsersWindow(id: "window-allusers")
                           // NSApplication.shared.terminate(nil)
                            
                            showUsersPanel()
                            
                        } label: {
                            Text("List all users")
                        }

                        
                    }
                Spacer()
                Image(systemName: "macbook")
                    .font(.system(size: 25))
                
                
            }
            .font(.system(.title2))
            .onAppear{
                
                userName = String(cString: userOnTheMac())
                let model = String(cString: modelOfTheMac())
                userName.append("'s \(model)")
                
            }

    }
    
    
    private func showUsersPanel() {
        if aboutWindowController == nil {
            // Create the window only if it doesn’t exist
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable, .titled, .resizable] // Removed .borderless for standard window look
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 400, height: 90), // Small size
                styleMask: styleMask,
                backing: .buffered,
                defer: false
            )
            window.title = "All users on this MacBook"
            window.contentView = NSHostingView(rootView: usersWindow())
            window.center() // Optional: Center the window on screen
            aboutWindowController = NSWindowController(window: window)
        }
        
        // Show the existing window (or the newly created one)
        aboutWindowController?.showWindow(nil)
        aboutWindowController?.window?.makeKeyAndOrderFront(nil) // Bring it to the front
    }
    
}


