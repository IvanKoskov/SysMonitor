//
//  sideBar.swift
//  SysMonitor
//
//  Created by Evan Matthew on 13/4/25.
//

import SwiftUI

struct sideBar: View {
    
    @EnvironmentObject var globaldata: globalDataModel
    
    @State private var helpMessagePopOver: Bool = false
    
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


            Spacer()
        }
        .offset(x: 13)
        .padding(.top, 26)
    }
}

