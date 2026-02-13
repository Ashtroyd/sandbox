import Foundation

protocol NoteStorage {
    func load() -> [BibleNote]
    func save(_ notes: [BibleNote])
}

final class UserDefaultsNoteStorage: NoteStorage {
    private let key: String
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(key: String = "bible_notes_v1", defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults

        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }

    func load() -> [BibleNote] {
        guard let data = defaults.data(forKey: key) else { return [] }

        do {
            return try decoder.decode([BibleNote].self, from: data)
        } catch {
            return []
        }
    }

    func save(_ notes: [BibleNote]) {
        do {
            let data = try encoder.encode(notes)
            defaults.set(data, forKey: key)
        } catch {
            assertionFailure("Unable to encode notes: \(error)")
        }
    }
}
