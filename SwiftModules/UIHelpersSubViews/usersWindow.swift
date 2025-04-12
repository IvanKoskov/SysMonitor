//
//  usersWindow.swift
//  SysMonitor
//
//  Created by Evan Matthew on 10/4/25.
//

import SwiftUI

struct usersWindow: View {
    
    @State private var users: [String?] = [""];
    
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            CustomVisualEffectBlur.dark
            
            ScrollView{
                
                VStack {
                    
                    ForEach(users, id: \.self) { user in
                        
                        Text(user ?? "ERROR")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                    }
                }
                .padding()
            }
       }
        
        .onAppear{
            if let cString = usersAll() {
                let swiftString = String(cString: cString)
                users = swiftString.split(separator: "\n").map { String($0) }
                print(users)
            } else {
                print("Failed to get users")
            }
            
            startRepeatingFunction()
           
        }
        .onDisappear{
            
            stopRepeatingFunction()
            
        }
    
    }
    
    private func updateDynamicInfo() {
        
        users.removeAll()
        
        if let cString = usersAll() {
            let swiftString = String(cString: cString)
            users = swiftString.split(separator: "\n").map { String($0) }
            print(users)
        } else {
            print("Failed to get users")
        }
        
    }
    
    
   private func startRepeatingFunction() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            updateDynamicInfo()
        }
    }
    
    // Stop the timer when the view disappears (to avoid memory leaks or unnecessary updates)
   private func stopRepeatingFunction() {
        timer?.invalidate()
    }
}

    
