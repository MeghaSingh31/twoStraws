//
//  ContentView.swift
//  PaulHudson_1_Split
//
//  Created by Megha on 11/18/24.
//

import SwiftUI

struct ContentView: View {
    @State var noOfPeople = 2
    @State var tipPercentage = 20
    @State var totalAmount = 0.0
    @FocusState var amountFocused: Bool
    var perPersonAmount: Double {
        let tipValue = Double(tipPercentage)
        let noOfPeople = Double(noOfPeople + 2)
        let perPersonTip = totalAmount * tipValue / 100
        let grandTotal = totalAmount + perPersonTip
        let perPersonTotal = grandTotal / noOfPeople
        return perPersonTotal
    }
    private var tipAmountArray = [10,15,20,25,30]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Total Amount", value: $totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocused)
                    
                    Picker("Number of People", selection: $noOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip you want to pay?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipAmountArray, id: \.self) { tipAmount in
                            Text(tipAmount, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Text(perPersonAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountFocused {
                    Button("Done") {
                        amountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
