
class Meeting {
  Meeting(
    this.eventName,
    this.from,
  );

  String eventName;
  DateTime from;

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      json['eventName'] as String,
      DateTime.parse(json['from'] as String),
    );
  }
}
