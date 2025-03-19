//
//  ScrollViewReaderSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI

struct ScrollViewReaderSample: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("enter # here...".uppercased(), text: $textFieldText)
                .padding()
                .frame(height: 55)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("GO") {
                withAnimation(.default) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            .font(.headline)
            .tint(.green)
            .buttonStyle(.borderedProminent)
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .foregroundStyle(.accent)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { _, newValue in
                        withAnimation(.default) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderSample()
}
