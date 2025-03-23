//
//  SubscriberSample.swift
//  SwiftUIContinuedLearning
//
//  Created by dofxmine on 22.03.2025.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                
                guard let self = self else { return }
                self.count += 1
                
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                
                if text.count > 3 {
                    return true
                }
                return false
                
            }
            // .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}


struct SubscriberSample: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)

            TextField("Type code...", text: $vm.textFieldText)
                .padding(.leading)
                .font(.headline)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.pink)
                            .opacity(vm.textFieldText.isEmpty ? 0 :
                                vm.textIsValid ? 0 : 1)
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.trailing)
                    , alignment: .trailing
                )
            
            Button("submit".uppercased()) {
                
            }
            .font(.headline)
            .foregroundStyle(.wb)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(vm.showButton ? 1.0 : 0.5)
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

#Preview {
    SubscriberSample()
}
