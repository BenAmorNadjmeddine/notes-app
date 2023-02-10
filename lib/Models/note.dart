class Note {
  late int id;
  late String title;
  late String body;
  late String date;
  late String time;
  late int color;
  late String status;

  Note({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.time,
    required this.color,
    required this.status,
  });

  Note.fromJSON(Map<String, dynamic>? json) {
    id = json!["id"];
    title = json["title"];
    body = json["body"];
    date = json["date"];
    time = json["time"];
    color = json["color"];
    status = json["status"];
  }
}
