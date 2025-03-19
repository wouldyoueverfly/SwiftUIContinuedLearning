//
//  MagnificationGestureInst.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 18.03.2025.
//

import SwiftUI

struct MagnificationGestureInst: View {
    
    @GestureState var magnifyBy = 1.0
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("Kind of priority")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal, 3)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(magnifyBy)
                .animation(.linear, value: magnifyBy)
                .gesture(
                    MagnifyGesture()
                        .updating($magnifyBy, body: { value, gestureState, transaction in
                                gestureState = value.magnification
                        })
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal, 3)
            .font(.headline)
            Text("Just do your thing and everything will be alright")
                .padding(.horizontal, 3)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
}

#Preview {
    MagnificationGestureInst()
}

