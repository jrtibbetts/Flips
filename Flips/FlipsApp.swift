//  Created by Jason R Tibbetts on 10/7/20.

import SwiftUI

@main
struct FlipsApp: App {
    let persistenceController = PersistenceController(inMemory: true)

    init() {
        [
            ("rith", "rite", "rith", "i", 1, false),
            ("ól", "ólta", "ól", "ó", 1, false),
            ("siúil", "siúlta", "siúl", "ú", 1, false),
        ].forEach { (verbEntry) in
            let verb = Verb(context: persistenceController.container.viewContext)
            verb.root = verbEntry.0
            verb.pastParticiple = verbEntry.1
            verb.verbalNoun = verbEntry.2
            verb.rootVowel = verbEntry.3
            verb.conjugation = Int16(verbEntry.4)
            verb.polysyllabic = verbEntry.5
        }
    }

    var body: some Scene {
        WindowGroup {
            CardsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
