//  Created by Jason R Tibbetts on 1/17/21.

import SwiftUI

struct HomeView: View {

    let gridItems = [GridItem(.adaptive(minimum: 100.0, maximum: 200.0))]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                LazyVGrid(columns: gridItems, alignment: .center, spacing: 20.0) {
                    NavigationLink(destination: WordListView<Noun>()) {
                        Text("Nouns")
                    }

                    NavigationLink(destination: WordListView<Verb>()) {
                        Text("Verbs")
                    }

                    NavigationLink(destination: PrepositionsOverview()) {
                        Text("Prepositions")
                    }
                }

                Spacer()
            }
            .navigationTitle("Gaeilge")
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
