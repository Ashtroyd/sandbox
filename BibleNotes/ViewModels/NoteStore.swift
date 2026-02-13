import Foundation

@MainActor
final class NoteStore: ObservableObject {
    @Published private(set) var notes: [BibleNote]
    @Published var selectedNoteID: UUID?
    @Published var searchText = ""

    private let storage: NoteStorage

    init(storage: NoteStorage = UserDefaultsNoteStorage()) {
        self.storage = storage

        let loaded = storage.load()
        self.notes = loaded.isEmpty ? BibleNote.sample : loaded
        self.selectedNoteID = self.notes.first?.id
    }

    var filteredNotes: [BibleNote] {
        let candidatePool: [BibleNote]

        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            candidatePool = notes
        } else {
            let query = searchText.lowercased()
            candidatePool = notes.filter { $0.searchableText.contains(query) }
        }

        return candidatePool.sorted {
            if $0.isPinned != $1.isPinned {
                return $0.isPinned && !$1.isPinned
            }
            return $0.updatedAt > $1.updatedAt
        }
    }

    func note(for id: UUID?) -> BibleNote? {
        guard let id else { return nil }
        return notes.first(where: { $0.id == id })
    }

    func createNote() {
        let newNote = BibleNote(title: "New Study Note", content: "")
        notes.insert(newNote, at: 0)
        selectedNoteID = newNote.id
        persist()
    }

    func updateNote(
        id: UUID,
        title: String,
        content: String,
        scriptureReference: String,
        tagsText: String
    ) {
        guard let index = notes.firstIndex(where: { $0.id == id }) else { return }

        var note = notes[index]
        note.title = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Untitled" : title
        note.content = content
        note.scriptureReference = scriptureReference
        note.tags = tagsText
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        note.touch()

        notes[index] = note
        persist()
    }

    func deleteNotes(ids: Set<UUID>) {
        notes.removeAll { ids.contains($0.id) }

        if ids.contains(selectedNoteID ?? UUID()) {
            selectedNoteID = filteredNotes.first?.id
        }

        persist()
    }

    func togglePin(for id: UUID) {
        guard let index = notes.firstIndex(where: { $0.id == id }) else { return }
        notes[index].isPinned.toggle()
        notes[index].touch()
        persist()
    }

    private func persist() {
        storage.save(notes)
    }
}
