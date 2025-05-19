//
//  SysMenu.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

import SwiftUI

struct SysMenu: View {
    
    @EnvironmentObject var globaldata: globalDataModel
  
    var body: some View {
        
        HStack {
            
            sideBar()
    
            TabView (selection: $globaldata.selectedTab){
                
                
                ScrollView {
                    
                    
                    CustomVisualEffectBlur.light
                    VStack {
                        
                        userView()
                        
                        Divider()
                        
                        AvailableSpaceGeneral()
                        
                        // Divider()
                        //  .offset(y: -12)
                        
                        footerSection()
                        
                        
                        Spacer()
                    }
                    .onAppear{
                        
                        
                        
                    }
                    .onDisappear{
                        
                        //  stopRepeatingFunction()
                        
                    }
                    .padding()
                    .frame(width: 300, height: 200)
                    
                }
                .scrollBounceBehavior(.always)
                .tabItem {
                    Label("Drives", systemImage: "externaldrive.fill.badge.questionmark")
                }
                .tag(0)
                
                vitalsView()
                    .tabItem {
                        Label("Vitals", systemImage: "externaldrive.fill.badge.questionmark")
                    }
                    .tag(1)
                
            }
            .tabViewStyle(.automatic)
            .padding()
            .onChange(of: globaldata.selectedTab) { changeTheHelpMessage() }
        }
    
    }
    
    
    private func changeTheHelpMessage() {
        
        if (globaldata.selectedTab == 0) {
            globaldata.sideBarHelpButtonText = "Explore SysMonitor's sleek interface, designed to give you quick, handy insights about your MacBook! Right now, we're spotlighting the Drives section, where you can effortlessly check key details like available disk space and other essential info about your machine's storage. It's all about keeping you informed with essential data!"
        } else if (globaldata.selectedTab == 1) {
            
            globaldata.sideBarHelpButtonText = "Monitor CPU, RAM, and GPU in real-time, perfect for gamers and developers optimizing performance. In order to keep the stats dynamic you do not need t"
            
        }
        
        
    }
    
}

