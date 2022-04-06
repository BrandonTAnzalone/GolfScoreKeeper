//
//  EditRoundView.swift
//  GolfScoreKeeper
//
//  Created by Brandon Anzalone on 3/23/22.
//

import SwiftUI

struct EditRoundView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    //CoreData Fetch
    var round: FetchedResults<Round>.Element
    
    @State private var courseName = ""
    @State private var par : Int = 0
    @State private var score = ""
    var pars = [70,72]
    
    
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading){
                    Text("Course Name: ")
                        .bold()
                    TextField("\(round.courseName!)", text: $courseName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear{
                            courseName = round.courseName!
                            par = Int(round.par)
                            score = String(round.score)
                        }
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
                    Button("Update") {
                        DataController().editRound(round: round, courseName: courseName, par: Double(par), score: Double(score) ?? 0, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }//VStack
            }
        }
        .navigationTitle("Edit Round")
    }
}

