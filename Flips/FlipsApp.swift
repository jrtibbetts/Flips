//  Created by Jason R Tibbetts on 10/7/20.

import SwiftUI

@main
struct FlipsApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        let ritheannVerb = Verb(context: persistenceController.container.viewContext)
        ritheannVerb.root = "rith"

        let imrionnVerb = Verb(context: persistenceController.container.viewContext)
        imrionnVerb.root = "imr"
    }

    var body: some Scene {
        WindowGroup {
            CardsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
