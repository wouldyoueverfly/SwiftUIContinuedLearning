//
//  LongPressGestureSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 18.03.2025.
//

import SwiftUI

struct LongPressGestureSample: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(width: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.primary)
        }
        
        HStack {
            Text("CLICK")
                .foregroundStyle(Color.accentColor)
                .padding()
                .background(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onLongPressGesture(
                    minimumDuration: 1.0,
                    maximumDistance: 15) {
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            })
                        }
                    }

            
            Text("RESET")
                .foregroundStyle(Color.accentColor)
                .padding()
                .background(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    withAnimation(.snappy) {
                        isComplete = false
                        isSuccess = false
                    }
                    
                }
        }
    }
}

#Preview {
    LongPressGestureSample()
}
