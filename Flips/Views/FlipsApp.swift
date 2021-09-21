//  Created by Jason R Tibbetts on 10/7/20.

import SwiftUI

@main
struct FlipsApp: App {

    var persistenceController = PersistenceController(inMemory: true)

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
