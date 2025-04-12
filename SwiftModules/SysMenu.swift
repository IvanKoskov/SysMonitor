//
//  SysMenu.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

import SwiftUI

struct SysMenu: View {

    var body: some View {
        
        
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
            .frame(width: 300, height: 450)
            
            
        }
  
    
    }
    
}

