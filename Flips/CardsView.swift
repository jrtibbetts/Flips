//  Created by Jason R Tibbetts on 10/7/20.

import CoreData
import SwiftUI

struct AddVerbView: View {

    var body: some View {
        VStack {
            Text("This is the AddVerbView")
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
                NavigationLink(destination: AddVerbView()) {
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
