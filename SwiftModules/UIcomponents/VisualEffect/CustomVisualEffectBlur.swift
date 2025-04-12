//
//  CustomVisualEffectBlur.swift
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

import AppKit
import SwiftUI

// Wont work on old MacOS

struct CustomVisualEffectBlur: NSViewRepresentable {
    let blurStyle: NSVisualEffectView.Material

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = blurStyle
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

extension CustomVisualEffectBlur {
    // Используем существующие материалы для macOS
    static var dark: CustomVisualEffectBlur {
        CustomVisualEffectBlur(blurStyle: .dark) // Темный материал
    }

    static var light: CustomVisualEffectBlur {
        CustomVisualEffectBlur(blurStyle: .light) // Светлый материал
    }
}

struct VisualEffect: NSViewRepresentable {
   func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
   func updateNSView(_ nsView: NSView, context: Context) { }
}
