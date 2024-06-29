
class Meeting {
  Meeting(
    this.id,
    this.eventName,
    this.from,
  );

  int id;  // Add this line
  String eventName;
  DateTime from;

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      json['id'] as int,  // Update this line
      json['eventName'] as String,
      DateTime.parse(json['from'] as String),
    );
  }
}
