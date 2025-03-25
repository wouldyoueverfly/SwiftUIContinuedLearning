//
//  AccessibilityColorsSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 25.03.2025.
//

import SwiftUI

struct AccessibilityColorsSample: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
            NavigationStack {
                ZStack {
                    Color.black.opacity(reduceTransparency ? 1 : 0.5).ignoresSafeArea()
                    
                    VStack {
                        
                        Button("Button 1") {
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(#colorLiteral(red: 0, green: 0.5607843137, blue: 0, alpha: 1)))
                        
                        Button("Button 2") {
                            
                        }
                        .foregroundStyle(colorSchemeContrast == .increased ? .wb : .purple)
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                        
                        Button("Button 3") {
                            
                        }
                        .foregroundStyle(.blue)
                        .buttonStyle(.borderedProminent)
                        .tint(.pink)
                        
                        Button("Button 4") {
                            
                        }
                        .foregroundStyle(.orange)
                        .buttonStyle(.borderedProminent)
                        
                    }
                    .font(.largeTitle.bold())
                    .navigationTitle("Nastya")
                }
            }
        
    }
}

#Preview {
    AccessibilityColorsSample()
}
