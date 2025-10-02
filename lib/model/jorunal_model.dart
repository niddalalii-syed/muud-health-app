class JournalEntry {
  final int id;
  final int userId;
  final String entryText;
  final int moodRating;
  final DateTime timestamp;

  JournalEntry({
    required this.id,
    required this.userId,
    required this.entryText,
    required this.moodRating,
    required this.timestamp,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'],
      userId: json['user_id'],
      entryText: json['entry_text'],
      moodRating: json['mood_rating'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
