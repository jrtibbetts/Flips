//  Created by Jason R Tibbetts on 10/7/20.

import SwiftUI

@main
struct FlipsApp: App {

    let verbModel = VerbModel()

    var body: some Scene {
        WindowGroup {
            CardsView()
                .environment(\.managedObjectContext, verbModel.viewContext)
        }
    }

}
