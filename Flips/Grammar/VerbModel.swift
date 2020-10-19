//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

public struct VerbModel {
    public let persistenceController = PersistenceController(inMemory: true)

    public var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }

    public init() {
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
                        if trimmedLine.isEmpty || trimmedLine.starts(with: "#") {
                            return
                        }

                        let verbData = trimmedLine.split(separator: ",")
                            .map { String($0).trimmingCharacters(in: .whitespaces) }
                        let verb = Verb(context: persistenceController.container.viewContext)
                        verb.dictionaryForm = stringOrNil(verbData[0])
                        verb.root = stringOrNil(verbData[1])
                        verb.simplePastRoot = stringOrNil(verbData[2])
                        verb.pastParticiple = stringOrNil(verbData[3])
                        verb.verbalNoun = stringOrNil(verbData[4])
                        verb.rootVowel = stringOrNil(verbData[5])
                        verb.conjugation = Int16(verbData[6]) ?? 1
                        verb.polysyllabic = Bool(verbData[7]) ?? false
                        verb.englishPresent = stringOrNil(verbData[8])
                        verb.englishPast = stringOrNil(verbData[9])
                        verb.englishPastParticiple = stringOrNil(verbData[10])
                    }
            }

            try persistenceController.container.viewContext.save()
        } catch {
            print("Error importing data: \(error.localizedDescription)")
        }
    }
}

