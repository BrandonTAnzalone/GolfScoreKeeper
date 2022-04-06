//
//  DataController.swift
//  GolfScoreKeeper
//
//  Created by Brandon Anzalone on 3/23/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "RoundModel")
    
    init() {
        container.loadPersistentStores { desc,error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved.")
        } catch {
            print("We could not save the data...")
        }
    }
    
    func addRound(courseName: String, par: Double, score: Double, context: NSManagedObjectContext) {
        let round = Round(context: context)
        round.id = UUID()
        round.date = Date()
        round.courseName  = courseName
        round.par = par
        round.score = score
        
        save(context: context)
    }
    
    func editRound(round: Round, courseName: String, par: Double, score: Double, context: NSManagedObjectContext) {
        
        round.date = Date()
        round.courseName = courseName
        round.par = par
        round.score = score
        
        save(context: context)
    }
}
