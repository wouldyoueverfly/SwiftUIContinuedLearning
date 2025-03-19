//
//  RotationGesture.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 19.03.2025.
//

import SwiftUI

struct RotationGesture: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.accent)
            .padding(50)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .rotationEffect(angle)
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        angle = value.rotation
                    }
                    .onEnded { value in
                        withAnimation(.default) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

#Preview {
    RotationGesture()
}
