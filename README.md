# Bible Notes (Apple Notes-style) in SwiftUI

This repository now includes a complete SwiftUI app implementation you can paste into a new Xcode iOS project to get an Apple Notes-style Bible study notebook.

## Features
- Sidebar + editor layout (Apple Notes feel)
- Create, edit, and delete notes
- Pin important notes
- Search by title/content/scripture/tags
- Scripture reference field
- Tags support (`faith, prayer, sermon`)
- Auto-save to local storage (`UserDefaults`)
- Starter sample notes

## Folder structure
- `BibleNotes/BibleNotesApp.swift`
- `BibleNotes/Models/BibleNote.swift`
- `BibleNotes/Services/NoteStorage.swift`
- `BibleNotes/ViewModels/NoteStore.swift`
- `BibleNotes/Views/RootView.swift`
- `BibleNotes/Views/NotesSidebarView.swift`
- `BibleNotes/Views/NoteEditorView.swift`

## How to run in Xcode (free Apple account)
1. Open Xcode → **File > New > Project**.
2. Choose **iOS App** with **SwiftUI**.
3. Name it `BibleNotes` (or any name).
4. Replace the generated Swift files with the files in this repo's `BibleNotes/` folder.
5. Connect your iPhone via cable.
6. In Xcode project settings:
   - **Signing & Capabilities** → choose your personal Apple ID team.
   - Ensure bundle identifier is unique (e.g. `com.yourname.biblenotes`).
7. Select your iPhone as the run target and press **Run**.

### Important for free accounts
- You can install on your own device for testing/personal use.
- App Store publishing is **not required** for this workflow.
- Free provisioning profiles expire periodically, so you may need to re-run from Xcode later.

## Optional next upgrades
- iCloud sync with CloudKit
- Rich text formatting
- Folder organization
- Lock notes with Face ID
- Export/share notes as PDF
