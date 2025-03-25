//
//  VisualEffectSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 25.03.2025.
//

import SwiftUI

struct VisualEffectSample: View {
    
//    @State private var showSpacer: Bool = false
    
    var body: some View {
        
        
        ScrollView {
            VStack(spacing: 30) {
                ForEach(0..<100) { index in
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)))
                        .frame(width: 300, height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)))
                        .visualEffect { content, geometryProxy in
                            content
                                .offset(x: geometryProxy.frame(in: .global).minY * 0.05)
                        }
                }
            }
        }
//        VStack {
//            Text("Hello, Nastya!")
//                .padding()
//                .background(.indigo)
//                .visualEffect{ content, geometry in
//                    content
//                        .grayscale(geometry.frame(in: .global).minY < 300 ? 1 : 0)
//                    //                        .grayscale(geometry.size.width >= 200 ? 1 : 0)
//                }
//            if showSpacer {
//                Spacer()
//            }
//        }
//        .animation(.default, value: showSpacer)
//        .onTapGesture {
//            showSpacer.toggle()
//        }
    }
}

#Preview {
    VisualEffectSample()
}
