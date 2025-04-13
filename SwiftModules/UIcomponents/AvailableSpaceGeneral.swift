//
//  AvailableSpaceGeneral.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

import SwiftUI

//view for displaying a progress like bar that will display availbale space

struct AvailableSpaceGeneral: View {
    @State private  var externalDrives: [String] = []
    @State private var timer: Timer? = nil
    @State private var diskState: String = String(cString: stateOfTheDisk())
    @State private var diskStateInPercents: String = String(cString: stateOfTheDiskInPercents())
  //  @State private var diskStatsItems: [String: String] = ["Disk state" : diskState]
    @EnvironmentObject var globaldata: globalDataModel
    @State private var shortForDrive: String = "Macintosh HD"
    @State private var mainDriveNameOnTheMacOS: String = ""
    @State private var showPopover: Bool = false
    
    var body: some View {
        
        
        VStack {
            
            Text(shortForDrive)
                .frame(maxWidth: .infinity, alignment: .leading) 
                .fontWeight(.bold)
                .font(.system(size: 15))
               // .textSelection(.enabled)
                .contextMenu{
                    
                    Text(mainDriveNameOnTheMacOS)
                        .textSelection(.enabled)
                    
                }
            
            
            HStack {
                
                ZStack(alignment: .leading){
                    //Shipped
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray)
                        .frame(width: 230, height: 5)
                    
                    
                    //available
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.green)
                        .frame(width: globaldata.getUsedSpaceOnTheBar(), height: 5)
                       // .offset(x: -10) not used now
                    
                    
                    
                }
                .onTapGesture {
                    showPopover = true
                }
                .popover(isPresented: $showPopover) {
                    
                    VStack {
                        
                        ScrollView {
                            
                            Text("Disk stats")
                                .textSelection(.enabled)
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                            
                            diskStatsItemOfTheList(Section: "Overall state", SectionInfo: diskState)
                            diskStatsItemOfTheList(Section: "Overall percentage", SectionInfo: diskStateInPercents)
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: 200, height: 140)
                    
                }
                
                Text(String(globaldata.spaceTotal) + "GB")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                    .textSelection(.enabled)
                
                
             //   Spacer() not used from now on
                
            }
            HStack {
                Text("\(globaldata.getUsedSpaceOnTheBar())" + "GB used")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 5)
                
                Text("\(globaldata.spaceAvailable)" + "GB free")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: -40)
                
            }
            
        }
        .onAppear{
            
            mainDriveNameOnTheMacOS.append(String(cString: getTheMount()))
            
            startRepeatingFunction()
           // mainDriveNameOnTheMacOS.append(String(cString: getTheMount()))
           // globaldata.spaceTotal = getTheTotalSpace()
           // globaldata.spaceAvailable = globaldata.spaceTotal - Double(get_used_disk_space())

            print(globaldata.spaceAvailable)
            print(globaldata.spaceTotal)
            
            
            
            
        }
        .onDisappear{
            
        stopRepeatingFunction()
            
        }
        
        
        
        Divider()
            
        
        ForEach(externalDrives, id: \.self) { drive in
            singleExternalDriveView(Drive: drive)
                         .padding(.bottom, 10) // Add some space between each view
                 }
        
        
    }
    
    
    func updateDynamicInfo() {
        externalDrives = getExternalDrives()
        
        if externalDrives.isEmpty {
            print("No external drives found")
        } else {
            for (index, path) in externalDrives.enumerated() {
                print("Drive \(index + 1): \(path)")
            }
        }
        
        globaldata.spaceTotal = getTheTotalSpace()
        globaldata.spaceAvailable = globaldata.spaceTotal - Double(get_used_disk_space())
        diskState = String(cString: stateOfTheDisk())
        diskStateInPercents = String(cString: stateOfTheDiskInPercents())
       }
       
       // Start the timer
       func startRepeatingFunction() {
           timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
               updateDynamicInfo()
           }
       }
       
       // Stop the timer when the view disappears (to avoid memory leaks or unnecessary updates)
       func stopRepeatingFunction() {
           timer?.invalidate()
       }
    
    
}

