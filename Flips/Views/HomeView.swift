//  Created by Jason R Tibbetts on 1/17/21.

import SwiftUI

struct HomeView: View {

    let verbModel = VerbModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CardsView()
                                .environment(\.managedObjectContext, verbModel.viewContext)) {
                    Text("Verbs")
                }
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
