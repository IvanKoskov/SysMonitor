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
            
            //custom sidebar like view
            VStack {
                Image(systemName: "bolt")
                Image(systemName: "hammer")
            }
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
                
                Text("hello")
                    .tabItem {
                        Label("Debug", systemImage: "externaldrive.fill.badge.questionmark")
                    }
                    .tag(1)
                
            }
            .tabViewStyle(.automatic)
            .padding()
        }
    
    }
    
}

