//
//  AboutView.swift
//  SysMonitor
//
//  Created by Evan Matthew on 4/4/25.
//

import SwiftUI

struct AboutView: View {
    
    @State private var donationsLabelHoweverColor: Color = .gray
    @State private var isHovering = false
    
    var body: some View {
        
        
        ZStack {
            CustomVisualEffectBlur.dark

                VStack {
                    
                    HStack {
                        
                        Image("generalimage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 75, minHeight: 75)
                            .offset(x: 10)
                        
                        
                        
                        VStack{
                            HStack {
                                Text("SysMonitor")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                //   .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("```Version 1.0.0 alpha```")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .offset(y: 2)
                                //.frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Easy to access utility for keeping in touch with your system statistics in place.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .offset(x: 15)
                        
                        Spacer()
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Text("```Previous releases```")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Link(destination: URL(string: "https://www.apple.com")!) {
                            Image(systemName: "link.circle")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Text("```Developed by```")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Link(destination: URL(string: "https://github.com/IvanKoskov")!) {
                            Text("Ivan Koskov")
                                .contextMenu{
                                    
                                    Text("Aka Evan Matthew")
                                    
                                }
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Text("```Donations```")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Link(destination: URL(string: "https://www.apple.com")!) {
                            Image(systemName: "heart.fill")
                                .font(.largeTitle)
                                .foregroundColor(donationsLabelHoweverColor)
                                .onHover { isHovering in
                                    donationsLabelHoweverColor = isHovering ? .red : .gray
                                }
                            
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Text("```Our apps```")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Link(destination: URL(string: "https://github.com/IvanKoskov/SXMac")!) {
                            Text("More from us")
                                .contextMenu{
                                    
                                    Text("This will direct you to our other projects!")
                                    
                                }
                        }
                    }
                    
                    
                    Spacer()
                    
                }
                .padding()
                .frame(width: 400, height: 250)
                
            
            
        }
    }
    

    
}


