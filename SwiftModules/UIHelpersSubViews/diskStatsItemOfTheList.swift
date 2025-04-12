//
//  diskStatsItemOfTheList.swift
//  SysMonitor
//
//  Created by Evan Matthew on 4/4/25.
//

import SwiftUI

struct diskStatsItemOfTheList: View {
    @State private var ideticalColor: Color = .white
    @State var Section: String
    @State var SectionInfo: String
    
    var body: some View {
   //     VStack {
            Divider()
            
            HStack{
                
                
                Text(Section)
                    .fontWeight(.bold)
                    .textSelection(.enabled)
                
                Spacer()
                
                Text(SectionInfo)
                    .foregroundColor(ideticalColor)
                    .textSelection(.enabled)
                    .font(.system(size: 12))
            }
            .onAppear{
                
                if (SectionInfo == "Good") {
                    
                    ideticalColor = .green
                    
                } else if (SectionInfo == "Moderate"){
                    
                    ideticalColor = .yellow
                    
                } else if (SectionInfo == "Bad"){
                    
                    ideticalColor = .orange
                    
                } else if (SectionInfo == "Critical") {
                    
                    ideticalColor = .red
                    
                }
                
                
            }
            
       // }
    }
}


