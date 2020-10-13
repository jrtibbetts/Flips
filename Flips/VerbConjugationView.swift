//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct InflectionCell: View {

    var ending: String? = ""

    var pronoun: String? = ""

    var root: String? = ""

    var body: some View {
        GeometryReader { (proxy) in
            let proxyWidth = proxy.size.width

            HStack {
                HStack {
                    Text(root ?? "")
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                    Text(ending ?? "" )
                        .font(.body)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
//                .frame(width: proxyWidth * 0.8)

                Text(pronoun ?? "")
//                    .frame(width: proxyWidth * 0.2)
            }

        }
    }
}

struct InflectionTableRow: View {

    var root: String = ""

    var singular: (ending: String?, pronoun: String)

    var plural: (ending: String?, pronoun: String)

    var body: some View {
        HStack {
            InflectionCell(ending: singular.ending, pronoun: singular.pronoun, root: root)
            InflectionCell(ending: plural.ending, pronoun: plural.pronoun, root: root)
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
                                   singular: (Verb.endings[Verb.Ending(person: .first,  number: .singular, tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender)], ""),
                                   plural:   (Verb.endings[Verb.Ending(person: .first,  number: .plural,   tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender)], ""))
                InflectionTableRow(root: verb.root!,
                                   singular: (Verb.endings[Verb.Ending(person: .second, number: .singular, tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender)], ""),
                                   plural:   (Verb.endings[Verb.Ending(person: .second, number: .plural,   tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender)], ""))
                InflectionTableRow(root: verb.root!,
                                   singular: (Verb.endings[Verb.Ending(person: .third,  number: .singular, tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender)], ""),
                                   plural:   (Verb.endings[Verb.Ending(person: .third,  number: .plural,   tense: .present, mood: .indicative, voice: .active, declension: .first, syllables: .single, vowel: .slender)], ""))
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
