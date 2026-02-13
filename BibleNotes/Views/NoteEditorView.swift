import SwiftUI

struct NoteEditorView: View {
    @EnvironmentObject private var store: NoteStore

    let note: BibleNote

    @State private var title: String
    @State private var scriptureReference: String
    @State private var tagsText: String
    @State private var content: String

    init(note: BibleNote) {
        self.note = note
        _title = State(initialValue: note.title)
        _scriptureReference = State(initialValue: note.scriptureReference)
        _tagsText = State(initialValue: note.tags.joined(separator: ", "))
        _content = State(initialValue: note.content)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextField("Title", text: $title)
                    .font(.title.bold())

                TextField("Scripture Reference (e.g. John 3:16)", text: $scriptureReference)
                    .textFieldStyle(.roundedBorder)

                TextField("Tags (comma separated)", text: $tagsText)
                    .textFieldStyle(.roundedBorder)

                Divider()

                TextEditor(text: $content)
                    .font(.body)
                    .frame(minHeight: 320)
                    .overlay(alignment: .topLeading) {
                        if content.isEmpty {
                            Text("Write your reflection, sermon notes, prayer points, and action steps…")
                                .foregroundStyle(.tertiary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                    }
            }
            .padding()
        }
        .navigationTitle("Study Note")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: title) { _, _ in saveDraft() }
        .onChange(of: scriptureReference) { _, _ in saveDraft() }
        .onChange(of: tagsText) { _, _ in saveDraft() }
        .onChange(of: content) { _, _ in saveDraft() }
        .onChange(of: note.id) { _, _ in
            title = note.title
            scriptureReference = note.scriptureReference
            tagsText = note.tags.joined(separator: ", ")
            content = note.content
        }
    }

    private func saveDraft() {
        store.updateNote(
            id: note.id,
            title: title,
            content: content,
            scriptureReference: scriptureReference,
            tagsText: tagsText
        )
    }
}
