import SwiftUI
import Charts

struct vitalsView: View {
    @State private var timer: Timer?
    @State private var showMoreAboutRamChart: Bool = false
    @EnvironmentObject var globaldata: globalDataModel
    @State private var dataRam: [(name: String, ram: Int)] = [
        (name: "Free RAM", ram: 0),
        (name: "Used RAM", ram: 0),
        (name: "Total Mac RAM", ram: 0)
    ]
   
    var body: some View {
        
        ScrollView(.horizontal){
            HStack{
            VStack {
                Chart(dataRam, id: \.name) { element in
                    SectorMark(
                        angle: .value("Value", element.ram),
                        innerRadius: .ratio(0.5),
                        angularInset: 1
                    )
                    .cornerRadius(4)
                    .foregroundStyle(by: .value("Ram category", element.name))
                }
                .onTapGesture {
                    showMoreAboutRamChart = true
                }
                .popover(isPresented: $showMoreAboutRamChart){
                    ScrollView {
                        VStack {
                            Text("Free RAM: \(globaldata.freeRam)")
                            Divider()
                            Text("Used RAM: \(globaldata.usedRam)")
                            Divider()
                            Text("Total RAM: \(globaldata.totalRam)")
                        }
                        .frame(width: 140, height: 100)
                    }
                }
                .chartForegroundStyleScale([
                    "Free RAM": Color.green,
                    "Used RAM": Color.red,
                    "Total Mac RAM": Color.blue
                ])
                .offset(x: 10)
                .frame(width: 350, height: 210)
                
                
                
                
            }
                Divider().frame(width: 1)
                    .offset(x: -20)
                
                VStack {
                    
                    Button {
                        print("hello")
                    } label: {
                        Text("dummy")
                    }

                    
                }
            
        }
            
    }
        .frame(width: 300, height: 210)
      
        .onAppear {
            updateDynamicInfo()
            startRepeatingFunction()
        }
        .onDisappear {
            stopRepeatingFunction()
        }
        
        
        
    }

    func updateDynamicInfo() {
        globaldata.freeRam = max(ramFreeMemory(), 0)
        globaldata.usedRam = max(ramUsedMemory(), 0)
        globaldata.totalRam = max(totalRamMemory(), 0)
        dataRam = [
            (name: "Free RAM", ram: Int(globaldata.freeRam)),
            (name: "Used RAM", ram: Int(globaldata.usedRam)),
            (name: "Total Mac RAM", ram: Int(globaldata.totalRam))
        ]
        print("Updated dataRam: \(dataRam)")
    
    }

    func startRepeatingFunction() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            updateDynamicInfo()
        }
    }

    func stopRepeatingFunction() {
        timer?.invalidate()
    }
}
