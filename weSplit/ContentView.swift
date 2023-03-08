//
//  ContentView.swift
//  weSplit
//
//  Created by David OH on 06/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkamt = 0.0
      @State private var numberOfPeople = 2
      @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool //focus and unfocus keyboard
    
      let percentages = [10,15,20,25,0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkamt/100 * tipSelection
        let grandTotal = checkamt + tipValue
        return grandTotal/peopleCount
    }
    
    
    var totalCheckAmt : Double{
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkamt/100 * tipSelection
        return  checkamt + tipValue
    }
    
    
    var totalTipAmt : Double{
        let tipSelection = Double(tipPercentage)
        
        return checkamt/100 * tipSelection
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkamt, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker("Number Of People",selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }}
                    
                    Section{
                        Picker("Tips ",selection: $tipPercentage){
                            ForEach(percentages,id: \.self){
                                Text($0 ,format:.percent)
                            }
                        }.pickerStyle(.segmented)
                    }header: {
                        
                            Text("How much tip do you want to leave")
                    }
                    Section{
                        Text(totalPerPerson, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                    }header: {
                        
                        Text("Amount per person")
                }
                
                Section{
                    Text(totalCheckAmt, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }header: {
                    
                    Text("Total Check Amount")
            }
                Section{
                    Text(totalTipAmt, format: .currency(code:Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($isFocused)
                }header: {
                    
                    Text("Total Tip Amount")
            }
                
                
            }
            .navigationTitle("We split").toolbar{//attach done button to keyboard
                ToolbarItemGroup(placement: .keyboard){Spacer()
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
