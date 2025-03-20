//
//  HapticsSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI


class HapticManager {
    
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}


struct HapticsSample: View {
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            Button("success") {HapticManager.instance.notification(type: .success)}
                .buttonStyle(.borderedProminent)
                .tint(.red)
            Button("warning") {HapticManager.instance.notification(type: .warning)}
                .buttonStyle(.borderedProminent)
                .tint(.red)
            Button("error") {HapticManager.instance.notification(type: .error)}
                .buttonStyle(.borderedProminent)
                .tint(.red)
            Divider()
            Button("soft") {HapticManager.instance.impact(style: .soft)}
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
            Button("rigid") {HapticManager.instance.impact(style: .rigid)}
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
            Button("medium") {HapticManager.instance.impact(style: .medium)}
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
            Button("light") {HapticManager.instance.impact(style: .light)}
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
            Button("heavy") {HapticManager.instance.impact(style: .heavy)}
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
        }
    }
}

#Preview {
    HapticsSample()
}
