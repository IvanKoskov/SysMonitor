//
//  getOtherDrives.swift
//  SysMonitor
//
//  Created by Evan Matthew on 4/4/25.
//

import Foundation



func getExternalDrives() -> [String] {
    let fileManager = FileManager.default
    
    // Get all mounted volumes
    guard let mountedVolumes = fileManager.mountedVolumeURLs(
        includingResourceValuesForKeys: [.volumeNameKey],
        options: [.skipHiddenVolumes]
    ) else {
        print("Failed to get mounted volumes")
        return []
    }
    
    var externalDrives: [String] = []
    
    for volumeURL in mountedVolumes {
        let path = volumeURL.path
        
        // Skip the root filesystem
        if path == "/" {
            continue
        }
        
        // Get volume properties
        do {
            let resourceValues = try volumeURL.resourceValues(forKeys: [
                .volumeNameKey,
                .volumeIsRootFileSystemKey
            ])
            
            let isRoot = resourceValues.volumeIsRootFileSystem ?? false
            let volumeName = resourceValues.volumeName ?? "Unknown"
            
            print("Found volume: \(path)")
            print("  Name: \(volumeName)")
            print("  Is Root: \(isRoot)")
            
            // Since we can't reliably use volumeIsExternalKey, we'll assume
            // any non-root volume under /Volumes/ is external
            if !isRoot && path.hasPrefix("/Volumes/") && !path.isEmpty {
                externalDrives.append(path)
            }
        } catch {
            print("Error getting properties for \(path): \(error)")
        }
    }
    
    return externalDrives
}

