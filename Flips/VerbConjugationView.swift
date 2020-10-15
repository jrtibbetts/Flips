//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct InflectionCell: View {

    var ending: String? = ""

    var pronoun: String? = ""

    var verb: Verb?

    var body: some View {
        GeometryReader { (proxy) in
            HStack {
                HStack {
                    Text(verb?.root ?? "")
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 0)

                    if let ending = ending {
                        Text(ending)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -6)
                    }
                }

                if let pronoun = pronoun {
                    Text(pronoun)
                }
            }
        }
    }

}

struct InflectionTableRow: View {

    var inflector: VerbInflector

    var person: Verb.Person

    var body: some View {
        HStack {
            if let singularInflections = inflector.inflect(person: person, number: .singular) {
                InflectionCell(ending: singularInflections.ending,
                               pronoun: singularInflections.pronoun,
                               verb: inflector.verb)
            }

            if let pluralInflections = inflector.inflect(person: person, number: .plural) {
                InflectionCell(ending: pluralInflections.ending,
                               pronoun: pluralInflections.pronoun,
                               verb: inflector.verb)
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
                InflectionGroup(inflector: FirstConjugationSlenderPresentIndicative(verb: verb))
                InflectionGroup(inflector: FirstConjugationSlenderPastIndicative(verb: verb))
                InflectionGroup(inflector: FirstConjugationSlenderPastHabitualIndicative(verb: verb))
                InflectionGroup(inflector: FirstConjugationSlenderFutureIndicative(verb: verb))
           }

            Spacer()
        }
    }
}

struct InflectionGroup: View {

    var inflector: VerbInflector

    var body: some View {
        VStack {
            if let tense = inflector.tense {
                HStack {
                    Text(tense.rawValue.capitalized)
                        .font(.title2)
                    Spacer()
                }
            }

            ScrollView {
                InflectionTableRow(inflector: inflector, person: .first)
                InflectionTableRow(inflector: inflector, person: .second)
                InflectionTableRow(inflector: inflector, person: .third)
            }
        }
        .padding(10.0)
    }

}
struct VerbConjugationView_Previews: PreviewProvider {

    static var verb: Verb = {
        var verb = Verb(context: PersistenceController.preview.container.viewContext)
        verb.root = "rith"
        verb.rootVowel = "i"
        verb.pastParticiple = "rite"
        verb.verbalNoun = "rith"

        return verb
    }()

    static var previews: some View {
        VerbConjugationView(verb: verb)
    }

}
