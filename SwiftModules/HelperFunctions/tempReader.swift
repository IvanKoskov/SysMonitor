//
//  tempReader.swift
//  SysMonitor
//
//  Created by Evan Matthew on 25/4/25.
//



import IOKit

// SMC-related constants and structures
private let kSMCUserClientReadKey: UInt32 = 5

struct SMCKeyData {
    var key: UInt32
    var keyInfo: [CChar] // 5 bytes for key info
    var data: [UInt8]    // 32 bytes for data
    
    init() {
        key = 0
        keyInfo = Array(repeating: 0, count: 5)
        data = Array(repeating: 0, count: 32)
    }
}

func getCpuTemperature() -> Float {
    // Get AppleSMC service
    let service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleSMC"))
    guard service != 0 else { return -1.0 }
    defer { IOObjectRelease(service) }
    
    // Open connection to SMC
    var conn: io_connect_t = 0
    let result = IOServiceOpen(service, mach_task_self_, 0, &conn)
    guard result == kIOReturnSuccess else { return -1.0 }
    defer { IOServiceClose(conn) }
    
    // Prepare SMC key input
    var input = SMCKeyData()
    let key = "TC0P"
    input.key = key.utf8.reduce(0) { ($0 << 8) + UInt32($1) } // Convert string to UInt32
    
    // Call SMC to read key
    var output = SMCKeyData()
    var outputSize = MemoryLayout<SMCKeyData>.size
    let kr = IOConnectCallStructMethod(
        conn,
        kSMCUserClientReadKey,
        &input,
        MemoryLayout<SMCKeyData>.size,
        &output,
        &outputSize
    )
    
    guard kr == kIOReturnSuccess else { return -1.0 }
    
    // Convert result to temperature in Celsius
    return Float(output.data[6] >> 2) / 256.0
}



func getCPUTemperature() -> Double? {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", "ioreg -r -n AppleSMC -d 1 | grep -E 'TC([0-9])([CP])'"]
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.standardInput = nil
    
    do {
        try task.run()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else { return nil }
        
        // Parse the output to find temperature values
        let lines = output.components(separatedBy: .newlines)
        var temperatures = [Double]()
        
        for line in lines {
            if line.contains("TC") {
                let components = line.components(separatedBy: .whitespaces)
                if let hexComponent = components.last?.replacingOccurrences(of: "\"", with: ""),
                   let value = Int(hexComponent, radix: 16) {
                    let temp = Double(value) / 256.0
                    temperatures.append(temp)
                }
            }
        }
        
        // Return average of all core temperatures
        guard !temperatures.isEmpty else { return nil }
        return temperatures.reduce(0, +) / Double(temperatures.count)
        
    } catch {
        print("Error getting CPU temperature: \(error)")
        return nil
    }
}
