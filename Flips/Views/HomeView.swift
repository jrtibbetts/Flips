//  Created by Jason R Tibbetts on 1/17/21.

import SwiftUI

struct HomeView: View {

    let verbModel = VerbModel()

    let gridItems = [GridItem(.adaptive(minimum: 100.0, maximum: 200.0))]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                LazyVGrid(columns: gridItems, alignment: .center, spacing: 20.0) {
                    NavigationLink(destination: WordListView()
                                    .environment(\.managedObjectContext, verbModel.viewContext)) {
                        Text("Verbs")
                    }
                    .frame(width: 75.0, height: 75.0, alignment: .center)
                    .border(Color.green)
                }

                Spacer()
            }
            .navigationTitle("Home")
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
