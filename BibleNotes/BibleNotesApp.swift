import SwiftUI

@main
struct BibleNotesApp: App {
    @StateObject private var store = NoteStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}
