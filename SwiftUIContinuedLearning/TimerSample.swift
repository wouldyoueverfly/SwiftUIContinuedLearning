//
//  TimerSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 22.03.2025.
//

import SwiftUI

struct TimerSample: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    
    
    // MARK: Current Time:
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    // MARK: Countdown:
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    // MARK: Countdown to date:
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
//        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        timeRemaining = "\(minute):\(second)"
    }
    */
    
    // MARK: Animation counter:
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))],
                center: .center,
                startRadius: 5,
                endRadius: 500).ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.yellow)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.purple)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        }
    }
}

#Preview {
    TimerSample()
}
