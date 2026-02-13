import Foundation

struct BibleNote: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var scriptureReference: String
    var tags: [String]
    var isPinned: Bool
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        scriptureReference: String = "",
        tags: [String] = [],
        isPinned: Bool = false,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.scriptureReference = scriptureReference
        self.tags = tags
        self.isPinned = isPinned
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var preview: String {
        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Start your reflection…" : String(trimmed.prefix(140))
    }

    var searchableText: String {
        [title, content, scriptureReference, tags.joined(separator: " ")]
            .joined(separator: " ")
            .lowercased()
    }

    mutating func touch() {
        updatedAt = .now
    }

    static let sample: [BibleNote] = [
        BibleNote(
            title: "Sermon Notes: Faith Over Fear",
            content: "God's presence is greater than every unknown. Key verse: Isaiah 41:10.",
            scriptureReference: "Isaiah 41:10",
            tags: ["sermon", "faith"],
            isPinned: true
        ),
        BibleNote(
            title: "Morning Devotional",
            content: "Write a short prayer and 3 gratitude points before starting the day.",
            scriptureReference: "Psalm 5:3",
            tags: ["devotional", "prayer"]
        )
    ]
}
