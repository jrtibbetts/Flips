//  Created by Jason R Tibbetts on 10/7/20.

import SwiftUI

@main
struct FlipsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CardsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
