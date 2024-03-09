class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            description: json['description'],
            id: json['id'],
            isDone: json['isDone'],
            userId: json['userId'],
            date: json['date']);

  // TaskModel fromJson(Map<String, dynamic> json) {
  //   return TaskModel(
  //       title: json['title'],
  //       description: json['description'],
  //       id: json['id'],
  //       isDone: json['isDone'],
  //       date: json['date']);
  // }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "id": id,
      "isDone": isDone,
      "userId": userId,
      "date": date
    };
  }
}
