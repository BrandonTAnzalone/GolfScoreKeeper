//
//  ContentView.swift
//  GolfScoreKeeper
//
//  Created by Brandon Anzalone on 3/23/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    //gets data from database
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var round: FetchedResults<Round>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalRounds())) Total rounds")
                    .foregroundColor(.black)
                    .padding()
                    .font(.system(size: 20))
                List {
                    ForEach(round) { round in
                        NavigationLink(destination: EditRoundView(round:round)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(round.courseName!)
                                        .bold()
                                        .italic()
                                        .font(.system(size: 20))
                                        .foregroundColor(.green)
                                    HStack {
                                        Text("Score : \(Int(round.score))")
                                        Text("\(roundDif(par: round.par ,score: round.score))")
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Text(calcTimeSince(date:round.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteRound)
                }
                .listStyle(.grouped)
            }//VStack
            .background(Color.green)
            .navigationTitle("Golf Rounds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Round", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .accentColor(Color(.black))
            .font(.system(size:20))
        }//NavView
  
  
        .sheet(isPresented: $showingAddView) {
            AddRoundView()
        }
    }
    
    private func deleteRound(offsets: IndexSet) {
        withAnimation {
            offsets.map {round[$0]}.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    
    private func totalRounds() -> Double {
        var rounds: Double = 0
        for _ in round {
                rounds += 1
        }
        return rounds
    }
    
    private func roundDif(par: Double, score: Double) -> String {
        let dif = Int(score - par)
        var builtString = ""
        if(dif > 0)
        {
            builtString = "+ " + String(dif)
        }
        if(dif < 0)
        {
            builtString = String(dif)
        }
        return builtString
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
