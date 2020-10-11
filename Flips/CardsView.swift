//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct AddVerbView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @Binding var verbRoot: String

    var body: some View {
        VStack {
            Text("This is the AddVerbView")
            TextField("Verb Root",
                      text: $verbRoot,
                      onEditingChanged: { (successful) in
                      }) {
                let newVerb = Verb(context: viewContext)
                newVerb.root = "How do I get the text from the field?"

                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }

}

struct CardsView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @State var selectedRoot: String = "rith"

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Verb.root, ascending: true)],
        animation: .default)
    private var verbs: FetchedResults<Verb>

    var body: some View {
        NavigationView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))],
                      alignment: .center, spacing: 20) {
                NavigationLink(destination: AddVerbView(verbRoot: $selectedRoot)) {
                    Text("Placeholder")
                }
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
