//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct InflectionCell: View {

    var inflections: VerbInflection

    var body: some View {
        GeometryReader { (proxy) in
            HStack {
                HStack {
                    if let particle = inflections.particle {
                        Text(particle)
                            .font(.body)
                            .fontWeight(.bold)
                    }

                    Text(inflections.root)
                        .font(.body)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 0)

                    if let ending = inflections.ending {
                        Text(ending)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -8)
                    }
                }

                if let pronoun = inflections.pronoun {
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
                InflectionCell(inflections: singularInflections)
            }

            if let pluralInflections = inflector.inflect(person: person, number: .plural) {
                InflectionCell(inflections: pluralInflections)
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

            ScrollView {
                VStack {
                    InflectionGroup(inflector: FirstConjugationSlenderPresentIndicative(verb: verb))
                    InflectionGroup(inflector: FirstConjugationSlenderPastIndicative(verb: verb))
                    InflectionGroup(inflector: FirstConjugationSlenderPastHabitualIndicative(verb: verb))
                    InflectionGroup(inflector: FirstConjugationSlenderFutureIndicative(verb: verb))
                    InflectionGroup(inflector: FirstConjugationSlenderConditional(verb: verb))
                    InflectionGroup(inflector: FirstConjugationSlenderPresentSubjunctive(verb: verb))
                    InflectionGroup(inflector: FirstConjugationSlenderPastSubjunctive(verb: verb))
                }
            }
        }
    }
}

struct InflectionGroup: View {

    var inflector: VerbInflector

    var body: some View {
        VStack {
            HStack {
                Text(inflector.displayName)
                    .font(.title2)
                Spacer()
            }

            InflectionTableRow(inflector: inflector, person: .first)
            InflectionTableRow(inflector: inflector, person: .second)
            InflectionTableRow(inflector: inflector, person: .third)
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
        verb.polysyllabic = false

        return verb
    }()

    static var previews: some View {
        VerbConjugationView(verb: verb)
    }

}
