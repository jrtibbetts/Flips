//  Created by Jason R Tibbetts on 10/11/20.

import SwiftUI

struct VerbConjugationView: View {

    @Environment(\.verticalSizeClass) var verticalSizeClass

    @State private var showTranslation: Bool = false
    @State private var mode = VerbMode.positive
    @State private var showingVerbEditor = false
    @StateObject var verb: Verb

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
                            InflectionGroup(showTranslations: $showTranslation)
                                .environmentObject(FirstConjugationPresentIndicative(verb: verb,
                                                                                     mode: mode) as VerbInflector)
                            InflectionGroup(showTranslations: $showTranslation)
                                .environmentObject(FirstConjugationPastIndicative(verb: verb,
                                                                                  mode: mode) as VerbInflector)
                            InflectionGroup(showTranslations: $showTranslation)
                                .environmentObject(FirstConjugationImperfect(verb: verb,
                                                                                 mode: mode) as VerbInflector)

                            InflectionGroup(showTranslations: $showTranslation)
                                .environmentObject(FirstConjugationFutureIndicative(verb: verb,
                                                                                        mode: mode) as VerbInflector)
                        }

                        MoodView(.conditional) {
                            InflectionGroup(showTranslations: $showTranslation)
                                .environmentObject(FirstConjugationConditional(verb: verb,
                                                                               mode: mode) as VerbInflector)
                        }

                        MoodView(.subjunctive) {
                            InflectionGroup(showTranslations: $showTranslation)
                                .environmentObject(FirstConjugationPresentSubjunctive(verb: verb,
                                                                                      mode: mode) as VerbInflector)
                            InflectionGroup(showTranslations: $showTranslation)
                                .environmentObject(FirstConjugationPastSubjunctive(verb: verb,
                                                                                   mode: mode) as VerbInflector)
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
                Button("Translate") {
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
        VStack(alignment: .leading) {
            Text(mood.rawValue.capitalized)
                .font(.title)
                .frame(alignment: .leading)
            content
                .frame(alignment: .leading)
        }
        .padding()
        .scaledToFill()
    }

}

struct InflectionGroup: View {

    @EnvironmentObject var inflector: VerbInflector

    @Binding var showTranslations: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if let tense = inflector.tense?.rawValue {
                    Text(tense)
                        .font(.title2)
                }

                Spacer()

                if let translation = inflector.translation {
                    Text(translation)
                        .font(.body)
                        .italic()
                }
            }

            InflectionTableRow(person: .first, showTranslations: $showTranslations)
            InflectionTableRow(person: .second, showTranslations: $showTranslations)
            InflectionTableRow(person: .third, showTranslations: $showTranslations)
        }
        .padding([.top, .bottom], 10)
        .environmentObject(inflector)
    }

}

struct InflectionTableRow: View {

    @EnvironmentObject var inflector: VerbInflector

    var person: Verb.Person

    @Binding var showTranslations: Bool

    var body: some View {
        HStack {
            if let singularInflections = inflector.inflect(person: person, number: .singular) {
                InflectionCell(inflections: singularInflections,
                               showTranslations: $showTranslations)
            }

            if let pluralInflections = inflector.inflect(person: person, number: .plural) {
                InflectionCell(inflections: pluralInflections,
                               showTranslations: $showTranslations)
            }
       }
    }

}

struct InflectionCell: View {

    var inflections: VerbInflection

    @Binding var showTranslations: Bool

    var body: some View {
        GeometryReader { (proxy) in
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
        .frame(alignment: .top)
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
        Group {
            NavigationView {
                VerbConjugationView(verb: olVerb)
            }

            NavigationView {
                VerbConjugationView(verb: ceannaighVerb)
            }
        }
    }

}
