//
//  SysMonitorApp.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

/*

 
 _____               __  ___               _  __
/ ___/ __  __ _____ /  |/  /____   ____   (_)/ /_ ____   _____
\__ \ / / / // ___// /|_/ // __ \ / __ \ / // __// __ \ / ___/
___/ // /_/ /(__  )/ /  / // /_/ // / / // // /_ / /_/ // /
/____/ \__, //____//_/  /_/ \____//_/ /_//_/ \__/ \____//_/
    /____/

 By IvanKoskov aka EvanMatthew. All rights reserved.
 
 
 
 BSD 3-Clause License

 Copyright (c) [2025], [Ivan Koskov aka Evan Matthew]

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
*/


import SwiftUI
import FramelessWindow


@main
struct SysMonitorApp: App {
    
    @StateObject private var globaldata = globalDataModel()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        MenuBarExtra("SysMonitor App", image: "menubar") {
                 ZStack {
               
                     SysMenu()
                         
                 }

                 .environmentObject(globaldata)
             }
        .keyboardShortcut("s")
            
        .menuBarExtraStyle(.window)
        .commands {
                  CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                      Button(action: {
                          appDelegate.showAboutPanel()
                      }) {
                          Text("About SysMonitor")
                      }
                  }
              }
     
              .windowStyle(HiddenTitleBarWindowStyle())
              .windowResizability(.contentSize)
        
        WindowGroup("Window Title", id: "window-allusers") {
            usersWindow()
                .fixedSize()
                }
        
      .windowResizability(.contentSize)
    
        
      /*  WindowGroup {
            ContentView()
        }
       */
    }
}

