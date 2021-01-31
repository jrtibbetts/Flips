//  Created by Jason R Tibbetts on 1/29/21.

import SwiftUI

extension Noun: DetailDisplayable {

    func detailView() -> AnyView {
        AnyView(NounDetailView(noun: self))
    }

}

struct NounDetailView: View {

    @StateObject var noun: Noun

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NounDetailView_Previews: PreviewProvider {
    static var moon: Noun = {
        var noun = Noun(context: PersistenceController.preview.container.viewContext)
        noun.declension = 2
        noun.gender = "f"
        noun.root = "gealach"
        noun.genitive = "gealaí"
        noun.plural = "gealacha"
        noun.englishTranslation = "moon"

        return noun
    }()

    static var previews: some View {
        NounDetailView(noun: moon)
    }
}
