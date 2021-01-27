//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

public extension String {

    var stringOrNil: String? {
        return (self.lowercased() == "nil" || self.isEmpty) ? nil : self
    }

    var trimmed: String? {
        let trimmedLine = self.trimmingCharacters(in: .whitespaces)

        if trimmedLine.isEmpty || trimmedLine.starts(with: "#") {
            return nil
        } else {
            return trimmedLine
        }
    }

}
public struct VerbModel: PartOfSpeechModel {

    public var persistenceController = PersistenceController(inMemory: true)

    public init() {
        do {
            try lines(fromFilename: "verbs", ext: "csv").forEach { (line) in
                let elements = line.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }

                let verb = Verb(context: persistenceController.container.viewContext)
                verb.dictionaryForm = elements[0]
                verb.root = elements[1]
                verb.pastRoot = elements[2].stringOrNil ?? verb.root
                verb.pastRoot2 = elements[3].stringOrNil ?? verb.pastRoot
                verb.futureRoot = elements[4].stringOrNil ?? verb.root
                verb.pastParticiple = elements[5]
                verb.verbalNoun = elements[6]
                verb.rootVowel = elements[7]
                verb.conjugation = Int16(elements[8])!
                verb.polysyllabic = Bool(elements[9])!
                verb.transitive = Bool(elements[10])!
                verb.irregular = Bool(elements[11])!
                verb.englishPresent = elements[12]
                verb.englishTranslation = verb.englishPresent
                verb.englishPast = elements[13]
                verb.englishPastParticiple = elements[14]
            }

            try persistenceController.container.viewContext.save()
        } catch {
            print("Error importing verbs: \(error.localizedDescription)")
        }
    }
}

