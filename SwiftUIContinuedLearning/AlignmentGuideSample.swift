//
//  AlignmentGuideSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 25.03.2025.
//

import SwiftUI

struct AlignmentGuideSample: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, London")
                .background(Color.red)
//                .padding(.leading, -10)
//                .offset(x: -10)
                .alignmentGuide(.leading) { dimensions in
                    return dimensions.width * 0.5
                    
                }
            Text("Just let it go. Some things happen.")
                .background(Color.blue)
        }
        .background(Color.orange)
    }
}

struct AlignmentChildView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            row(title: "Anya", showIcon: false)
            row(title: "Nastya", showIcon: true)
            row(title: "Ksyusha", showIcon: false)
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View {
        HStack(spacing: 10) {
            
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        }
//        .background(.red)
        .alignmentGuide(.leading) { dimensions in
            return showIcon ? 40 : 0
        }
    }
}

#Preview {
    AlignmentChildView()
}
