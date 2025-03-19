//
//  MagnificationGesture.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 18.03.2025.
//

import SwiftUI

struct MagnificationGesture: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        Text("I don't know about girls, I just do my shit every day")
            .font(.caption)
            .padding()
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(1.0 + currentAmount + lastAmount)
            .gesture(
                MagnifyGesture()
                    .onChanged({ value in
                        currentAmount = value.magnification - 1.0
                    })
                    .onEnded { value in
                        lastAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

#Preview {
    MagnificationGesture()
}
