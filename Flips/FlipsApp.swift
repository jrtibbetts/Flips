//  Created by Jason R Tibbetts on 10/7/20.

import SwiftUI

@main
struct FlipsApp: App {
    let persistenceController = PersistenceController(inMemory: true)

    init() {
        let ritheann = Verb(context: persistenceController.container.viewContext)
        ritheann.root = "rith"
        ritheann.rootVowel = "i"
        ritheann.conjugation = 1
        ritheann.pastParticiple = "rite"
        ritheann.verbalNoun = "rith"
        ritheann.polysyllabic = false

        let olann = Verb(context: persistenceController.container.viewContext)
        olann.root = "ól"
        olann.rootVowel = "ó"
        olann.pastParticiple = "ólta"
        olann.verbalNoun = "ól"
        olann.polysyllabic = false
    }

    var body: some Scene {
        WindowGroup {
            CardsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
