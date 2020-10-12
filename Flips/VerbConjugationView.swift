//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct InflectionCell: View {

    var ending: String = ""

    var pronoun: String = ""

    var root: String = ""

    var body: some View {
        GeometryReader { (proxy) in
            let proxyWidth = proxy.size.width

            HStack {
                HStack {
                    Text(root)
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                    Text(ending)
                        .font(.body)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
//                .frame(width: proxyWidth * 0.8)

                Text(pronoun)
//                    .frame(width: proxyWidth * 0.2)
            }

        }
    }
}

struct InflectionTableRow: View {

    var root: String = ""

    var singular: (ending: String, pronoun: String)

    var plural: (ending: String, pronoun: String)

    var body: some View {
        GeometryReader { (proxy) in
            let proxyWidth = proxy.size.width

            HStack {
                InflectionCell(ending: singular.ending, pronoun: singular.pronoun, root: root)
//                    .frame(width: proxyWidth * 0.5)
                InflectionCell(ending: plural.ending, pronoun: plural.pronoun, root: root)
//                    .frame(width: proxyWidth * 0.5)
           }
        }
    }

}

struct VerbConjugationView: View {

    var verb: Verb

    var body: some View {
        VStack {
            HStack {
                Text(verb.root ?? "(no root)")
                    .font(.title)
            }

            VStack {
                Text("Present")
                    .font(.title2)

                InflectionTableRow(root: verb.root!,
                                   singular: ("im", ""),
                                   plural: ("imid", ""))
                InflectionTableRow(root: verb.root!,
                                   singular: ("eann", "tú"),
                                   plural: ("eann", "sibh"))
                InflectionTableRow(root: verb.root!,
                                   singular: ("eann", "sé/sí"),
                                   plural: ("eann", "siad"))
            }

            Spacer()
        }
    }
}

struct VerbConjugationView_Previews: PreviewProvider {

    static var verb: Verb = {
        var verb = Verb(context: PersistenceController.preview.container.viewContext)
        verb.root = "siul"

        return verb
    }()

    static var previews: some View {
        VerbConjugationView(verb: verb)
    }

}
