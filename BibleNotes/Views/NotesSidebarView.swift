import SwiftUI

struct NotesSidebarView: View {
    @EnvironmentObject private var store: NoteStore

    var body: some View {
        List(selection: $store.selectedNoteID) {
            ForEach(store.filteredNotes) { note in
                Button {
                    store.selectedNoteID = note.id
                } label: {
                    NoteRowView(note: note)
                }
                .buttonStyle(.plain)
                .contextMenu {
                    Button(note.isPinned ? "Unpin" : "Pin") {
                        store.togglePin(for: note.id)
                    }
                }
                .tag(note.id)
            }
            .onDelete { offsets in
                let ids = Set(offsets.map { store.filteredNotes[$0].id })
                store.deleteNotes(ids: ids)
            }
        }
        .navigationTitle("Bible Notes")
        .searchable(text: $store.searchText, prompt: "Search notes, scriptures, tags")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    store.createNote()
                } label: {
                    Label("New Note", systemImage: "square.and.pencil")
                }
            }
        }
    }
}

private struct NoteRowView: View {
    let note: BibleNote

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(note.title)
                    .font(.headline)
                    .lineLimit(1)

                Spacer()

                if note.isPinned {
                    Image(systemName: "pin.fill")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
            }

            if !note.scriptureReference.isEmpty {
                Text(note.scriptureReference)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Text(note.preview)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}
