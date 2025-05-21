//
//  singleExternalDriveView.swift
//  SysMonitor
//
//  Created by Evan Matthew on 4/4/25.
//

import SwiftUI
import Foundation

struct singleExternalDriveView: View {
    @State private var timer: Timer? = nil
    
    @State var Drive: String
    @State private var DriveFile: String = ""
    
    @State private var spaceTotal: Int = 1
    @State private var spaceAvailable: Int = 1
    @State private var barAvailableSpace: Int = 0
    
    @State private var showDriveStats: Bool = false
    
    var body: some View {
        
        VStack {
            
            
            Text(Drive)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
                .font(.system(size: 15))
            // .textSelection(.enabled)
                .contextMenu{
                    
                    Text("Externally mounted drive")
                        .textSelection(.enabled)
                    
                }
            Text(DriveFile)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .textSelection(.enabled)
                .offset(y: 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack {
                
                
                ZStack(alignment: .leading){
                    //Shipped
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray)
                        .frame(width: 230, height: 5)
                    
                    
                    //available
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.green)
                        .frame(width: CGFloat(getUsedSpaceOnTheBar()), height: 5)
                       // .offset(x: -10) not used now
                    
                    
                    
                }
                
                Text("\(spaceTotal) GB")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                    .textSelection(.enabled)
                
                
            }
            .onTapGesture {
                showDriveStats = true
            }
            .popover(isPresented: $showDriveStats){
                
                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        
                        Text("Drive stats")
                            .textSelection(.enabled)
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        
                        let userData = userData()
                        
                        diskStatsItemOfTheList(Section: "Overall state", SectionInfo: userData.percentage(ofHowMuchDiskSpaceIsUsed: 1, with: Int32(spaceTotal - spaceAvailable), also: Int32(spaceTotal)))
                        diskStatsItemOfTheList(Section: "Overall state", SectionInfo: userData.percentage(ofHowMuchDiskSpaceIsUsed: 0, with: Int32(spaceTotal - spaceAvailable), also: Int32(spaceTotal)))
                        diskStatsItemOfTheList(Section: "Encryption is", SectionInfo: userData.isEncrypted(Drive))
                        
                        Divider()
                        
                        Button {
                            let resulted: Bool =  ejectExternalDriveAtPath(path: Drive)
                            if (resulted == false){
                                
                                print("ERROR EJECTING")
                                
                            }
                        } label: {
                            Text("Eject drive")
                        }

                        
                        Spacer()
                    }
                    
                }
                .padding()
                .frame(width: 200, height: 140)
                
            }
            
            HStack {
                Text("\(spaceTotal - spaceAvailable)GB used")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 5)
                
                Text("\(spaceAvailable)GB free")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: -40)
                
            }
            
            
        }
       
        .onAppear{
            
            let fileURL = URL(fileURLWithPath: Drive)
            DriveFile = fileURL.lastPathComponent
           // print("THIS IIIIIIS ONN \(DriveFile)")
            
         //   let userData = userData()
          //  print(userData.availableSpace(forVolumePath: Drive))
            startRepeatingFunction()
            
        }
        .onDisappear {
            stopRepeatingFunction()
        }
        
        Divider()
            .offset(y: 10)
    }
    
    private func updateDynamicInfo() {
        
        let userData = userData()
        spaceTotal = Int(userData.totalCapacity(forVolumePathFixed: Drive))
        spaceAvailable = Int(userData.availableSpace(forVolumePath: Drive))
        barAvailableSpace = Int(getUsedSpaceOnTheBar())
        
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
    
    
    
   private func getUsedSpaceOnTheBar() -> Double {
        // Calculate the used space
        let spaceUsed = spaceTotal - spaceAvailable
        
        // Debugging: print the values to see what's going wrong
        print("Space Total: \(spaceTotal) GB")
        print("Space Available: \(spaceAvailable) GB")
        print("Space Used: \(spaceUsed) GB")
        
        // If spaceUsed is negative, there is an issue
        if spaceUsed < 0 {
            print("ERROR: Used space is negative!")
            return 0  // Return 0 to avoid negative width
        }
        
        // Calculate the width of the progress bar
       let result = Double((230 * spaceUsed) / spaceTotal)
        
        // Round the result to two decimal places
        let roundedResult = round(result * 100) / 100  // Round to 2 decimal places
        print("Used space on the bar: \(roundedResult) pixels")
       
     //  barAvailableSpace = Int(roundedResult)
        
        return roundedResult
    }

    
    
}

