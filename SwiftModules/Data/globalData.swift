//
//  File.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

import Foundation

class globalDataModel : ObservableObject {
    @Published var selectedTab = 0  //for the main window
    @Published var spaceTotal: Double = 1
    @Published var spaceAvailable: Double = 1
    // @Published var spaceTotalOnExternalDrive: [String: Double] = [:]
    // @Published var spaceAvailbaleOnExternalDrive: [String: Double] = [:]
    
    func getUsedSpaceOnTheBar() -> Double {
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
        let result = (230 * spaceUsed) / spaceTotal
        
        // Round the result to two decimal places
        let roundedResult = round(result * 100) / 100  // Round to 2 decimal places
        print("Used space on the bar: \(roundedResult) pixels")
        
        return roundedResult
    }



    
    
}
