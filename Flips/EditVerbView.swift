//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct EditVerbView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var presentationMode

    var verb: Verb

    @State var verbRoot: String = ""

    var body: some View {
        VStack {
            Text("This is the AddVerbView")
            TextField("Verb Root", text: $verbRoot)
                .onAppear {
                    self.verbRoot = self.verb.root?.lowercased() ?? ""
                }

            Button("Add") {
                verb.root = verbRoot

                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }

                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }

}


struct EditVerbView_Previews: PreviewProvider {

    static var verb = Verb(context: PersistenceController.preview.container.viewContext)

    static var previews: some View {
        EditVerbView(verb: verb)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}
