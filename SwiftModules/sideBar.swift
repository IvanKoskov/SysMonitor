//
//  sideBar.swift
//  SysMonitor
//
//  Created by Evan Matthew on 13/4/25.
//

import SwiftUI

struct sideBar: View {
    @State private var aboutWindowController: NSWindowController? 
    
    @EnvironmentObject var globaldata: globalDataModel
    
    @State private var helpMessagePopOver: Bool = false
    
    @State private var showMoreAboutUS: Bool = false
    
    var body: some View {
        //custom sidebar like view
        VStack {
            
            Button {
                print(globaldata.sideBarHelpButtonText)
                helpMessagePopOver = true
            } label: {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 20))
            }
            .buttonStyle(.plain)
            .popover(isPresented: $helpMessagePopOver){
                ScrollView {
                    VStack {
                        
                        
                        Text(globaldata.sideBarHelpButtonText)
                            .textSelection(.enabled)
                            
                        
                    }
                    .padding()
                    .frame(width: 220, height: 230)
                }
            }
            
            Button {
               NSApplication.shared.terminate(nil) //quit the app
            } label: {
                Image(systemName: "power")
                    .font(.system(size: 20))
            }
            .buttonStyle(.plain)
            .padding(.top, 2)
            .contextMenu{
                
                Button {
                    NSApplication.shared.terminate(nil)
                } label: {
                    Text("This will exit the SysMonitor and kill all processes related to it")
                }

            }
            
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
            
            Button(action: {
                showMoreAboutUS = true
            }) {
                Image(systemName: "network")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.borderless)
            .popover(isPresented: $showMoreAboutUS) {
                
                VStack {
                    Link(destination: URL(string: "https://github.com/IvanKoskov")!) {
                        Image("git")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    .font(.system(size: 10))
                    
                    Link(destination: URL(string: "https://t.me/Evan_Matthew")!) {
                        Image("tg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    .font(.system(size: 10))
                    
                    Link(destination: URL(string: "https://reddit.com")!) {
                        Image("reddit")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    .font(.system(size: 10))
                    
                }
                .frame(width: 30, height: 100)
            }
           
            
         

            Spacer()
        }
        .offset(x: 13)
        .padding(.top, 26)
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

