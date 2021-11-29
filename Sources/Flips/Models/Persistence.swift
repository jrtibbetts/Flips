//  Created by Jason R Tibbetts on 10/7/20.

import CoreData

public struct PersistenceController {
    public static let shared = PersistenceController()

    public static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    public let container: NSPersistentContainer

    public init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Flips")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        initializeNouns()
        initializeVerbs()
    }

    func initializeVerbs() {
        do {
            try lines(fromFilename: "verbs", ext: "csv").forEach { (line) in
                let elements = line.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }

                let verb = Verb(context: container.viewContext)
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

            try container.viewContext.save()
        } catch {
            print("Error importing verbs: \(error.localizedDescription)")
        }
    }

    func initializeNouns() {
        do {
            try lines(fromFilename: "nouns", ext: "csv").forEach { (line) in
                let elements = line.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                let noun = Noun(context: container.viewContext)
                noun.root = elements[0]
                noun.dictionaryForm = noun.root
                noun.gender = elements[1]
                noun.declension = Int16(elements[2]) ?? 1
                noun.genitive = elements[3]
                noun.plural = elements[4]
                noun.strongPlural = Bool(elements[5]) ?? false
                noun.englishTranslation = elements[6]
                noun.englishTranslationPlural = elements[7]
            }

            try container.viewContext.save()
        } catch {
            print("Error importing nouns: \(error.localizedDescription)")
        }
    }

    func lines(fromFilename filename: String, ext: String?) throws -> [String] {
        if let csvUrl = Bundle.main.url(forResource: filename, withExtension: ext) {
            return try String(contentsOf: csvUrl, encoding: .utf8)  // full file
                .components(separatedBy: CharacterSet.newlines)     // lines
                .compactMap { $0.trimmed }
        } else {
            return []
        }
    }

}

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
