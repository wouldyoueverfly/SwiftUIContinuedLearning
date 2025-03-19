//
//  DragGestureSample2.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI

struct DragGestureSample2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.primary.ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .animation(.default, value: currentDragOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                                currentDragOffsetY = value.translation.height
                        }
                        .onEnded { value in
                            if currentDragOffsetY < -150 {
                                endingOffsetY = -startingOffsetY
                            } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                endingOffsetY = 0
                            }
                                currentDragOffsetY = 0
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureSample2()
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my favourite SwiftUI Course. I recommend my friends to pe patient whatever they do in their life.")
                .multilineTextAlignment(.center)
            
            Text("Create an account".uppercased())
                .foregroundStyle(.accent)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.accent)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
