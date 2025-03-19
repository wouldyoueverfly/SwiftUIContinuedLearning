//
//  MultipleSheetsSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MultipleSheetsSample: View {
    
    @State var selectedModel: RandomModel? = nil
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    var body: some View {
        
        
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<100) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                    .font(.headline)
                    .tint(.green)
                    .buttonStyle(.borderedProminent)
                }
                
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
        
        
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Text(selectedModel.title)
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    MultipleSheetsSample()
}
