//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct AddVerbView: View {

    @Environment(\.managedObjectContext) private var viewContext

    var verb: Verb

    @State var verbRoot: String = ""

    var body: some View {
        VStack {
            Text("This is the AddVerbView")
            TextField("Verb Root", text: $verbRoot)
                .onAppear {
                    self.verbRoot = self.verb.root ?? ""
                }
//            TextField("Verb Root",
//                      text: $verb.root ?? "(no root)",
//                      onEditingChanged: { (successful) in
//                      }) {
//                do {
//                    try viewContext.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nsError = error as NSError
//                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                }
//            }
        }
    }

}

struct CardsView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Verb.root, ascending: true)],
        animation: .default)
    private var verbs: FetchedResults<Verb>

    var body: some View {
        NavigationView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                      alignment: .center, spacing: 20) {
                NavigationLink("Add Verb", destination: AddVerbView(verb: Verb(context: viewContext)))

//                ForEach(verbs) { verb in
//                    NavigationLink(verb.root ?? "(no root)", destination: AddVerbView(verb: verb))
//                }
//                .onDelete(perform: deleteItems)
            }
//            .toolbar {
//                HStack {
//                    //                #if os(iOS)
//                    //                EditButton()
//                    //                #endif
//
//                    Button(action: addVerb) {
//                        Label("Add Verb", systemImage: "plus")
//                    }
//                }
//            }
        }
    }

//    private func addVerb() {
//        withAnimation {
//            let newVerb = Verb(context: viewContext)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
