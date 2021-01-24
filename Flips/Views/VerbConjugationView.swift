//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

protocol WordDetailView: View {

    associatedtype W: Word

    var word: W { get }

}

struct VerbConjugationView: WordDetailView {

    @Environment(\.verticalSizeClass) var verticalSizeClass

    @State private var showTranslation: Bool = false
    @State private var mode = VerbMode.positive
    @State private var showingVerbEditor = false
    @StateObject var verb: Verb

    var word: Verb {
        return verb
    }

    var body: some View {
        VStack(alignment: .leading) {
            if showingVerbEditor {
                VerbEditor(verb: Verb(context: PersistenceController.preview.container.viewContext),
                           showingVerbEditor: $showingVerbEditor)
                    .animation(.easeInOut)
            } else {
                Picker("", selection: $mode) {
                    ForEach(VerbMode.allCases, id: \.self) { (mode) in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.top, .bottom])

                ScrollView {
                    VStack {
                        MoodView(.indicative) {
                            InflectionGroup(inflector: PresentIndicative(verb: verb,
                                                                         mode: mode),
                                            showTranslations: $showTranslation)
                            InflectionGroup(inflector: PastIndicative(verb: verb,
                                                                      mode: mode),
                                            showTranslations: $showTranslation)
                            InflectionGroup(inflector: Imperfect(verb: verb,
                                                                 mode: mode),
                                            showTranslations: $showTranslation)

                            InflectionGroup(inflector: FutureIndicative(verb: verb,
                                                                        mode: mode),
                                            showTranslations: $showTranslation)
                        }
                        
                        MoodView(.conditional) {
                            InflectionGroup(inflector: Conditional(verb: verb,
                                                                   mode: mode),
                                            showTranslations: $showTranslation)
                        }
                        
                        MoodView(.subjunctive) {
                            InflectionGroup(inflector: PresentSubjunctive(verb: verb,
                                                                          mode: mode),
                                            showTranslations: $showTranslation)
                            InflectionGroup(inflector: PastSubjunctive(verb: verb,
                                                                       mode: mode),
                                            showTranslations: $showTranslation)
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing], 5)
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if verticalSizeClass == .compact {
                    HStack {
                        headlineView
                        subheadlineView
                    }
                } else {
                    VStack {
                        headlineView
                        subheadlineView
                    }
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button((showTranslation ? "Hide" : "Show") + " Translation") {
                    showTranslation.toggle()
                }
                .font(.body)
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Button(showingVerbEditor ? "Cancel" : "Add Verb") {
                    showingVerbEditor.toggle()
                }
            }
        }
    }

    var headlineView: some View {
        Text(verb.dictionaryForm ?? "-")
            .font(.headline)
    }

    var subheadlineView: some View {
        Text(verb.englishPresent ?? "")
            .font(.subheadline)
            .italic()
    }

}

struct MoodView<Content>: View where Content: View {

    let content: Content

    var mood: Verb.Mood

    init(_ mood: Verb.Mood,
         @ViewBuilder content: () -> Content) {
        self.mood = mood
        self.content = content()
    }

    var body: some View {
        VStack {
            Text(mood.rawValue.capitalized)
                .font(.title)
                .frame(alignment: .leading)
            content
                .frame(alignment: .leading)
        }
        .padding()
    }

}

struct InflectionGroup: View {

    var inflector: VerbInflector

    @Binding var showTranslations: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if let tense = inflector.tense?.rawValue {
                    Text(tense)
                        .font(.title2)
                }

                if let translation = inflector.translation {
                    Spacer()

                    Text(translation)
                        .font(.body)
                        .italic()
                }
            }

            HStack {
                VStack(alignment: .leading) {
                    if let firstSingular = inflector.inflect(person: .first, number: .singular) {
                        InflectionCell(inflections: firstSingular, showTranslations: $showTranslations)
//                            .alignmentGuide(.leading, computeValue: { d in d[.leading]})
                    }

                    if let secondSingular = inflector.inflect(person: .second, number: .singular) {
                        InflectionCell(inflections: secondSingular, showTranslations: $showTranslations)
                    }

                    if let thirdSingular = inflector.inflect(person: .third, number: .singular) {
                        InflectionCell(inflections: thirdSingular, showTranslations: $showTranslations)
                    }
                }
                .frame(alignment: .leading)
                .border(Color.blue)

                Spacer()

                VStack(alignment: .leading) {
                    if let firstPlural = inflector.inflect(person: .first, number: .plural) {
                        InflectionCell(inflections: firstPlural, showTranslations: $showTranslations)
                    }

                    if let secondPlural = inflector.inflect(person: .second, number: .plural) {
                        InflectionCell(inflections: secondPlural, showTranslations: $showTranslations)
                    }

                    if let thirdPlural = inflector.inflect(person: .third, number: .plural) {
                        InflectionCell(inflections: thirdPlural, showTranslations: $showTranslations)
                    }

                }
                .frame(alignment: .leading)
                .border(Color.red)
            }
        }

        if inflector.verb.transitive {
            AutonomousInflectionTableRow(inflector: inflector, showTranslations: $showTranslations)
        }
    }
//    .padding([.top, .bottom], 10)

}

struct AutonomousInflectionTableRow: View {

    var inflector: VerbInflector

    @Binding var showTranslations: Bool

    var body: some View {
        HStack {
            Spacer()

            if let inflections = inflector.inflect(person: .autonomous, number: .singular) {
                InflectionCell(inflections: inflections, showTranslations: $showTranslations)
            }

            Spacer()
        }
    }
}

struct InflectionCell: View {

    var inflections: VerbInflection

    @Binding var showTranslations: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let particle = inflections.particle {
                    Text(particle)
                        .font(.body)
                        .fontWeight(.bold)
                }
                
                if let prefix = inflections.prefix {
                    Text(prefix)
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(.trailing, -8)
                }
                
                Text(inflections.root)
                    .font(.body)
                    .frame(alignment: .leading)
                    .padding(.trailing, 0)
                
                if let ending = inflections.ending {
                    Text(ending)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                        .padding(.leading, -8)
                }
                
                if let pronoun = inflections.pronoun {
                    Text(pronoun)
                }
            }
            .frame(alignment: .leading)
            
            if showTranslations,
               let translation = inflections.translation {
                Text(translation)
                    .font(.footnote)
                    .italic()
                    .frame(alignment: .leading)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
        .frame(alignment: .leading)
    }

}

struct VerbConjugationView_Previews: PreviewProvider {

    static var olVerb: Verb = {
        var verb = Verb(context: PersistenceController.preview.container.viewContext)
        verb.dictionaryForm = "ól"
        verb.root = "ól"
        verb.conjugation = 1
        verb.rootVowel = "ó"
        verb.pastParticiple = "ólta"
        verb.verbalNoun = "ól"
        verb.polysyllabic = false
        verb.englishPresent = "drink"
        verb.englishPast = "drank"
        verb.englishPastParticiple = "drunk"

        return verb
    }()

    static var ceannaighVerb: Verb = {
        var verb = Verb(context: PersistenceController.preview.container.viewContext)
        verb.dictionaryForm = "ceannaigh"
        verb.root = "ceann"
        verb.conjugation = 2
        verb.rootVowel = "a"
        verb.pastParticiple = "ceannaithe"
        verb.verbalNoun = "ceannach"
        verb.polysyllabic = true
        verb.englishPresent = "buy"
        verb.englishPast = "bought"
        verb.englishPastParticiple = "bought"

        return verb
    }()

    static var previews: some View {
//        Group {
//            NavigationView {
//                VerbConjugationView(verb: olVerb)
//            }

            NavigationView {
                VerbConjugationView(verb: ceannaighVerb)
            }
//        }
    }

}
