//  Created by Jason R Tibbetts on 10/7/20.

import SwiftUI

@main
struct FlipsApp: App {
    let persistenceController = PersistenceController(inMemory: true)

    init() {
        func stringOrNil(_ str: String) -> String? {
            return str == "nil" ? nil : str
        }

        do {
            if let verbUrl = Bundle.main.url(forResource: "verbs", withExtension: "csv") {
                try String(contentsOf: verbUrl, encoding: .utf8)    // full file
                    .components(separatedBy: CharacterSet.newlines) // lines
                    .forEach { (line) in
                        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
                        print("Line: \"\(trimmedLine)\"")
                        if trimmedLine.isEmpty {
                            return
                        }

                        let verbData = trimmedLine.split(separator: ",")
                            .map { String($0).trimmingCharacters(in: .whitespaces) }
                        let verb = Verb(context: persistenceController.container.viewContext)
                        verb.root = stringOrNil(verbData[0])
                        verb.simplePastRoot = stringOrNil(verbData[1])
                        verb.pastParticiple = stringOrNil(verbData[2])
                        verb.verbalNoun = stringOrNil(verbData[3])
                        verb.rootVowel = stringOrNil(verbData[4])
                        verb.conjugation = Int16(verbData[5]) ?? 1
                        verb.polysyllabic = Bool(verbData[6]) ?? false
                        verb.englishPresent = stringOrNil(verbData[7])
                        verb.englishPast = stringOrNil(verbData[8])
                        verb.englishPastParticiple = stringOrNil(verbData[9])
                    }
            }

            try persistenceController.container.viewContext.save()
        } catch {
            print("Error importing data: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            CardsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
