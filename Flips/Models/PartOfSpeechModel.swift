//  Created by Jason R Tibbetts on 1/27/21.

import CoreData
import SwiftUI

public protocol PartOfSpeechModel {

    var persistenceController: PersistenceController { get }

}

public extension PartOfSpeechModel {

    var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
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
