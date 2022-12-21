import 'dart:convert';

class ReadingLog {
  String bookId;
  DateTime startTime;
  DateTime endTime;
  int pages;
  int minutes;

  ReadingLog({
    required this.bookId,
    required this.startTime,
    required this.endTime,
    required this.pages,
    required this.minutes,
  });

  ReadingLog copyWith({
    String? id,
    String? bookId,
    DateTime? startTime,
    DateTime? endTime,
    int? pages,
    int? minutes,
  }) {
    return ReadingLog(
      bookId: bookId ?? this.bookId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      pages: pages ?? this.pages,
      minutes: minutes ?? this.minutes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookId': bookId,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'pages': pages,
      'minutes': minutes,
    };
  }

  factory ReadingLog.fromMap(Map<String, dynamic> map) {
    return ReadingLog(
      bookId: map['bookId'] as String,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      pages: map['pages'] as int,
      minutes: map['minutes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadingLog.fromJson(String source) =>
      ReadingLog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReadingLog(bookId: $bookId, startTime: $startTime, endTime: $endTime, pages: $pages, minutes: $minutes)';
  }

  @override
  bool operator ==(covariant ReadingLog other) {
    if (identical(this, other)) return true;

    return other.bookId == bookId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.pages == pages &&
        other.minutes == minutes;
  }

  @override
  int get hashCode {
    return bookId.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        pages.hashCode ^
        minutes.hashCode;
  }
}
