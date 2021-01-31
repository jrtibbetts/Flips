//  Created by Jason R Tibbetts on 1/18/21.

import CoreData
import SwiftUI

public struct NounModel: PartOfSpeechModel {

    public var persistenceController = PersistenceController.preview

    public init() {
        do {
            try lines(fromFilename: "nouns", ext: "csv").forEach { (line) in
                let elements = line.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                let noun = Noun(context: persistenceController.container.viewContext)
                noun.root = elements[0]
                noun.dictionaryForm = noun.root
                noun.gender = elements[1]
                noun.declension = Int16(elements[2]) ?? 1
                noun.genitive = elements[3]
                noun.plural = elements[4]
                noun.englishTranslation = elements[5]
            }

            try persistenceController.container.viewContext.save()
        } catch {
            print("Error importing nouns: \(error.localizedDescription)")
        }
    }

}
