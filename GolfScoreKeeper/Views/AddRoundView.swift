//
//  AddRoundView.swift
//  GolfScoreKeeper
//
//  Created by Brandon Anzalone on 3/23/22.
//

import SwiftUI

struct AddRoundView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var courseName = ""
    @State private var par : Int = 0
    @State private var score = ""
    var pars = [70,72]
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Course Name: ")
                            .bold()
                        TextField("Course Name" , text: $courseName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
  
                    VStack(alignment: .leading) {
                        Text("Course Par:")
                            .bold()
                        Picker("", selection: $par) {
                            ForEach(pars, id: \.self) {
                                Text("\($0)").tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding()
                    
                    VStack(alignment: .leading)
                    {
                        Text("Your Score: ")
                            .bold()
                        TextField("Your Score", text: $score)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                  
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController().addRound(courseName: courseName, par: Double(par), score: Double(score) ?? 0, context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }//HStack
                }//Section
                
            }//Form
            .navigationTitle("Add Round")
            
        }
    }
}

struct AddRoundView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoundView()
    }
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
