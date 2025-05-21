//
//  eject.swift
//  SysMonitor
//
//  Created by Evan Matthew on 21/5/25.
//

import Foundation
import AppKit

func ejectExternalDriveAtPath(path: String) -> Bool {
    // Convert the path to a file URL
    let fileURL = URL(fileURLWithPath: path)
    
    // Check if the volume exists and is mounted
    guard FileManager.default.fileExists(atPath: fileURL.path) else {
        print("Error: No volume found at path \(path)")
        return false
    }
    
    // Use NSWorkspace to unmount and eject the volume
    do {
        try NSWorkspace.shared.unmountAndEjectDevice(at: fileURL)
        print("Successfully ejected volume at \(path)")
        return true
    } catch {
        print("Failed to eject volume at \(path): \(error.localizedDescription)")
        return false
    }
}
