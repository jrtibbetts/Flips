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
                        verb.dictionaryForm = verbData[0]
                        verb.root = verbData[1]
                        verb.pastRoot = stringOrNil(verbData[2]) ?? verb.root
                        verb.pastRoot2 = stringOrNil(verbData[3]) ?? verb.pastRoot
                        verb.futureRoot = stringOrNil(verbData[4]) ?? verb.root
                        verb.pastParticiple = verbData[5]
                        verb.verbalNoun = verbData[6]
                        verb.rootVowel = verbData[7]
                        verb.conjugation = Int16(verbData[8])!
                        verb.polysyllabic = Bool(verbData[9])!
                        verb.englishPresent = verbData[10]
                        verb.englishPast = verbData[11]
                        verb.englishPastParticiple = verbData[12]
                    }
            }

            try persistenceController.container.viewContext.save()
        } catch {
            print("Error importing data: \(error.localizedDescription)")
        }
    }
}

