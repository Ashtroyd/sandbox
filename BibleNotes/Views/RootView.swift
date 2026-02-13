import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: NoteStore

    var body: some View {
        NavigationSplitView {
            NotesSidebarView()
        } detail: {
            if let note = store.note(for: store.selectedNoteID) {
                NoteEditorView(note: note)
            } else {
                ContentUnavailableView(
                    "No Note Selected",
                    systemImage: "book.closed",
                    description: Text("Create a Bible study note to get started.")
                )
            }
        }
        .tint(.purple)
    }
}

#Preview {
    RootView()
        .environmentObject(NoteStore())
}
