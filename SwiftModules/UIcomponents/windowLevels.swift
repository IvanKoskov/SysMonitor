//
//  windowLevels.swift
//  SysMonitor
//
//  Created by Evan Matthew on 13/4/25.
//

import Foundation

import SwiftUI
import AppKit





class PersistentPanel: NSPanel {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }

    init(contentRect: NSRect, backing: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.titled, .utilityWindow, .nonactivatingPanel], backing: backing, defer: flag)
        self.isFloatingPanel = true
        self.hidesOnDeactivate = false
        self.level = .floating
    }
}


struct WindowAccessor: NSViewRepresentable {
    var callback: (NSWindow?) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView(frame: .zero)
        view.isHidden = true

        DispatchQueue.main.async {
            callback(view.window)
        }

        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}



class WindowManager: ObservableObject {
    static let shared = WindowManager()
    weak var window: NSWindow?

    func toggleWindow() {
        guard let window = window else { return }

        if window.isVisible {
            window.orderOut(nil)
        } else {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
}



