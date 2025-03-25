//
//  AccessibilityVoiceOverSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 25.03.2025.
//

import SwiftUI

struct AccessibilityVoiceOverSample: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Volume", isOn: $isActive)
                    
                    HStack {
                        Text("Volume")
                        Spacer()
                        
                        Text(isActive ? "TRUE" : "FALSE")
                            .accessibilityHidden(true)
                    }
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(isActive ? "is on" : "is off")
                    .accessibilityHint("Double tap to toggle setting.")
                    .accessibilityAction {
                        isActive.toggle()
                    }
                } header: {
                    Text("PREFERENCIES")
                }
                Section {
                    Button("Favourites") {
                        
                    }
                    .accessibilityRemoveTraits(.isButton)
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .accessibilityLabel("Favourites")
                    Text("Favourites")
                        .accessibilityAddTraits(.isButton)
                        .onTapGesture {
                            
                        }
                } header: {
                    Text("APPLICATION")
                }
                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                        .accessibilityAddTraits(.isHeader)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 8) {
                            ForEach(1..<11) { x in
                                VStack {
                                    Image("anya")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(10)
                                        //.accessibilityHint("Number \(x)")
                                    
                                    Text("Anya #\(x)")
                                }
                                .onTapGesture {
                                    
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Anya #\(x). The most beautiful girl in the world.")
                                .accessibilityHint("Double tap to open")
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    AccessibilityVoiceOverSample()
}
